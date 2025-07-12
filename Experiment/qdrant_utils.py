import os
from typing import List

from dotenv import load_dotenv
from qdrant_client import QdrantClient
from qdrant_client.models import PointStruct, VectorParams, Distance
from openai import OpenAI
import numpy as np


def get_qdrant_client() -> QdrantClient:
    load_dotenv()
    host = os.getenv("QDRANT_SERVER_IP", "localhost")
    port = int(os.getenv("QDRANT_PORT", 6333))
    return QdrantClient(host=host, port=port)


def load_pdf_and_chunk(filepath: str, chunk_size: int = 1024, overlap: int = 128) -> List[str]:
    """Load ``filepath`` using PyPDF2 and split its text into chunks."""
    if not os.path.exists(filepath):
        raise FileNotFoundError(f"The file was not found: {filepath}")

    try:
        from PyPDF2 import PdfReader
    except Exception as exc:
        raise ImportError("PyPDF2 is required to process PDF files.") from exc

    reader = PdfReader(filepath)
    full_text = ""
    for page in reader.pages:
        text = page.extract_text() or ""
        full_text += text + "\n"

    chunks = []
    start = 0
    while start < len(full_text):
        end = min(start + chunk_size, len(full_text))
        chunks.append(full_text[start:end])
        start += chunk_size - overlap

    return chunks


def get_embedding(text: str, model: str = "text-embedding-3-large") -> List[float]:
    """Return an embedding for the given text.

    If an ``OPENAI_API_KEY`` is present in the environment, the OpenAI API is
    used. Otherwise a simple deterministic fallback embedding is generated so
    the demo can run without external tokens.
    """
    load_dotenv()
    api_key = os.getenv("OPENAI_API_KEY")
    if api_key:
        client = OpenAI(api_key=api_key)
        response = client.embeddings.create(input=text, model=model)
        return response.data[0].embedding

    # fallback: deterministic embedding based on byte values
    vector = np.zeros(512, dtype=float)
    for i, b in enumerate(text.encode("utf-8")):
        vector[i % 512] += float(b)
    return vector.tolist()


def embed_chunks(chunks: List[str]) -> List[List[float]]:
    return [get_embedding(chunk) for chunk in chunks]


def store_embeddings_in_qdrant(client: QdrantClient, collection_name: str, chunks: List[str], embeddings: List[List[float]]):
    collections = client.get_collections().collections
    if collection_name not in [c.name for c in collections]:
        client.recreate_collection(
            collection_name=collection_name,
            vectors_config=VectorParams(size=len(embeddings[0]), distance=Distance.COSINE)
        )
        next_id = 0
    else:
        next_id = client.count(collection_name=collection_name, exact=True).count

    points = [
        PointStruct(id=next_id + i, vector=vector, payload={"text": chunks[i]})
        for i, vector in enumerate(embeddings)
    ]
    client.upsert(collection_name=collection_name, points=points)


def retrieve_similar_chunks(query: str, client: QdrantClient, collection_name: str, top_k: int = 5) -> List[str]:
    collections = client.get_collections().collections
    if collection_name not in [c.name for c in collections]:
        # no collection yet, nothing to retrieve
        return []

    query_vector = get_embedding(query)
    search_result = client.search(
        collection_name=collection_name,
        query_vector=query_vector,
        limit=top_k,
    )
    return [hit.payload["text"] for hit in search_result]


def answer_with_context(query: str, context_chunks: list[str], model: str = "gpt-4o") -> str:
    """
    Nutzt OpenAI GPT-4o, um eine Antwort auf eine Frage zu geben – basierend auf den gegebenen Kontext-Chunks.

    Args:
        query (str): Die Benutzerfrage
        context_chunks (list[str]): Liste von Texten aus Qdrant
        model (str): OpenAI-Modellname (standardmäßig GPT-4o)

    Returns:
        str: Generierte Antwort
    """
    load_dotenv()
    api_key = os.getenv("OPENAI_API_KEY")
    if not api_key:
        raise ValueError("OPENAI_API_KEY was not found in the .env file.")

    client = OpenAI(api_key=api_key)

    # Prompt zusammenbauen
    context = "\n\n".join(context_chunks)
    prompt = f"Beantworte die folgende Frage auf Deutsch mit dem angehängten Kontext:\n\nFrage: {query}\n\nKontext:\n{context}"

    try:
        response = client.chat.completions.create(
            model=model,
            messages=[
                {"role": "system", "content": "You are a helpful assistant for scientific paper analysis and scientific question answering."},
                {"role": "user", "content": prompt}
            ],
            temperature=0.0
        )
        return response.choices[0].message.content.strip()
    except Exception as e:
        print(f"Error during answer generation: {e}")
        return "Error during answer generation."
    
def evaluate_llm_as_judge(
    question_id: str,
    question: str,
    answer_llm: str,
    answer_gold: str,
    model: str = "gpt-4o"
) -> str:
    """
    Nutzt GPT-4o, um eine LLM-as-a-Judge-Bewertung zwischen einer generierten Antwort und der Gold-Referenz zu erstellen.

    Args:
        question_id (str): ID der Frage
        question (str): Die gestellte Frage
        answer_llm (str): Die vom Modell generierte Antwort
        answer_gold (str): Die Goldstandard-Antwort
        model (str): OpenAI-Modellname (standardmäßig GPT-4o)

    Returns:
        str: JSON-String mit den Bewertungen für fünf Kriterien (0–2 Skala), Gesamtpunktzahl, Pass/Fail und Erläuterungsnotizen.
    """
    load_dotenv()
    api_key = os.getenv("OPENAI_API_KEY")
    if not api_key:
        raise ValueError("OPENAI_API_KEY not found in environment.")
    client = OpenAI(api_key=api_key)

    system_prompt = """
You are an expert evaluator.
Your task is to judge the candidate answer (`answer_llm`) against the reference answer (`answer_gold`) 
for the given question (`question_string`).

Use the following three-point scale for each criterion:
  0 = not fulfilled at all (the answer is incorrect, irrelevant, or missing)
  1 = partially fulfilled (the answer shows some correct elements but is incomplete or imprecise)
  2 = fully fulfilled (the answer is correct, complete and precise)

Evaluate on these five criteria exactly:
1. Factual correctness: Are the facts in the answer correct and accurate?
2. Completeness: Does the answer cover all aspects of the question?
3. Relevance: Is the answer relevant to the question asked?
4. Justification: Is the answer well-justified with clear reasoning?
5. Depth: Does the answer show a deep understanding of the topic?

Then compute:
- overall_score = sum of the five individual scores
- max_score = 10
- pass = true if overall_score ≥ 8, otherwise false

Output your evaluation as a single JSON object with these fields:
{
  "question_id": string,
  "factual_correctness": 0–2,
  "completeness":        0–2,
  "relevance":           0–2,
  "justification":       0–2,
  "depth":               0–2,
  "overall_score":       integer,
  "max_score":           10,
  "pass":                boolean,
}
"""

    user_prompt = f"""
    Evaluate the following question and answers:
question_id: "{question_id}"
question_string: "{question}"
answer_llm: "{answer_llm}"
answer_gold: "{answer_gold}"
"""

    response = client.chat.completions.create(
        model=model,
        messages=[
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": user_prompt}
        ],
        temperature=0.0
    )

    return response.choices[0].message.content.strip()
