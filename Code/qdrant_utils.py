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


def load_pdf_and_chunk(filepath: str, chunk_size: int = 500, overlap: int = 50) -> List[str]:
    if not os.path.exists(filepath):
        raise FileNotFoundError(f"The file was not found: {filepath}")

    try:
        from PyPDF2 import PdfReader
    except Exception as exc:
        raise ImportError("PyPDF2 is required to process PDF files.") from exc

    reader = PdfReader(filepath)
    full_text = ""
    for page in reader.pages:
        text = page.extract_text()
        if text:
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


def answer_with_context(query: str, context_chunks: List[str], model: str = "gpt-4o") -> str:
    """Generate an answer for ``query`` using the provided ``context_chunks``.

    When an OpenAI API key is available, the GPT model is queried. If not, the
    context is returned verbatim so the application remains usable without
    external services.
    """
    load_dotenv()
    api_key = os.getenv("OPENAI_API_KEY")

    context = "\n\n".join(context_chunks)

    if api_key:
        client = OpenAI(api_key=api_key)
        prompt = (
            f"Answer the following question based on the context:\n\nContext:\n{context}\n\nQuestion: {query}"
        )
        response = client.chat.completions.create(
            model=model,
            messages=[
                {"role": "system", "content": "You are a helpful assistant for scientific questions."},
                {"role": "user", "content": prompt},
            ],
            temperature=0.2,
        )
        return response.choices[0].message.content.strip()

    # fallback: return raw context when no API key is configured
    return f"Context:\n{context}\n\nQuestion: {query}"
