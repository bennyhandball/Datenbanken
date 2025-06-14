import os
from qdrant_client import QdrantClient
from dotenv import load_dotenv


def get_qdrant_client() -> QdrantClient:
    """Create and return a Qdrant client using credentials from .env."""
    load_dotenv()

    url = os.getenv("QDRANT_URL")
    api_key = os.getenv("QDRANT_API_KEY")

    if not url:
        raise ValueError("QDRANT_URL is not set in the environment")

    # api_key may be optional if qdrant does not require it
    return QdrantClient(url=url, api_key=api_key)


if __name__ == "__main__":
    client = get_qdrant_client()
    # Example health check request
    try:
        info = client.get_liveness()
        print("Qdrant is alive:" if info else "No response from Qdrant")
    except Exception as exc:
        print(f"Failed to connect to Qdrant: {exc}")
