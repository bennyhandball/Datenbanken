import os
from typing import List

try:
    import fitz  # PyMuPDF
except Exception as e:  # pragma: no cover - optional dependency
    fitz = None
from dotenv import load_dotenv
from qdrant_client import QdrantClient
from qdrant_client.models import PointStruct, VectorParams, Distance
from openai import OpenAI


def get_qdrant_client() -> QdrantClient:
    load_dotenv()
    host = os.getenv("QDRANT_SERVER_IP", "localhost")
    port = int(os.getenv("QDRANT_PORT", 6333))
    return QdrantClient(host=host, port=port)


def load_pdf_and_chunk(filepath: str, chunk_size: int = 500, overlap: int = 50) -> List[str]:
    """Load a PDF file and split it into overlapping chunks."""
    if not os.path.exists(filepath):
        raise FileNotFoundError(f"The file was not found: {filepath}")

    if fitz is None or not hasattr(fitz, "open"):
        raise ImportError(
            "PyMuPDF is required for PDF processing. Install it with 'pip install PyMuPDF'."
        )

    doc = fitz.open(filepath)
    full_text = ""
    for page in doc:
        full_text += page.get_text("text") + "\n"
    doc.close()

    chunks = []
    start = 0
    while start < len(full_text):
        end = min(start + chunk_size, len(full_text))
        chunks.append(full_text[start:end])
        start += chunk_size - overlap

    return chunks


def get_embedding(text: str, model: str = "text-embedding-3-large") -> List[float]:
    load_dotenv()
    api_key = os.getenv("OPENAI_API_KEY")
    if not api_key:
        raise ValueError("OPENAI_API_KEY was not found in the .env file.")

    client = OpenAI(api_key=api_key)
    response = client.embeddings.create(input=text, model=model)
    return response.data[0].embedding


def embed_chunks(chunks: List[str]) -> List[List[float]]:
    return [get_embedding(chunk) for chunk in chunks]


def store_embeddings_in_qdrant(client: QdrantClient, collection_name: str, chunks: List[str], embeddings: List[List[float]]):
    """Store embeddings in Qdrant, creating the collection if needed."""
    collections = client.get_collections().collections
    if collection_name not in [c.name for c in collections]:
        client.create_collection(
            collection_name=collection_name,
            vectors_config=VectorParams(size=len(embeddings[0]), distance=Distance.COSINE)
        )

    points = [
        PointStruct(id=i, vector=vector, payload={"text": chunks[i]})
        for i, vector in enumerate(embeddings)
    ]
    client.upsert(collection_name=collection_name, points=points)


def retrieve_similar_chunks(query: str, client: QdrantClient, collection_name: str, top_k: int = 5) -> List[str]:
    collections = client.get_collections().collections
    if collection_name not in [c.name for c in collections]:
        raise ValueError(
            f"Collection '{collection_name}' not found. Please upload a document first."
        )

    query_vector = get_embedding(query)
    search_result = client.search(
        collection_name=collection_name,
        query_vector=query_vector,
        limit=top_k
    )
    return [hit.payload["text"] for hit in search_result]


def answer_with_context(query: str, context_chunks: List[str], model: str = "gpt-4o") -> str:
    load_dotenv()
    api_key = os.getenv("OPENAI_API_KEY")
    if not api_key:
        raise ValueError("OPENAI_API_KEY was not found in the .env file.")

    client = OpenAI(api_key=api_key)
    context = "\n\n".join(context_chunks)
    prompt = f"Answer the following question based on the context:\n\nContext:\n{context}\n\nQuestion: {query}"
    response = client.chat.completions.create(
        model=model,
        messages=[
            {"role": "system", "content": "You are a helpful assistant for scientific questions."},
            {"role": "user", "content": prompt}
        ],
        temperature=0.2
    )
    return response.choices[0].message.content.strip()
