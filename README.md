# Datenbanken

Datenbanken_Portfolio

## Qdrant RAG Connection

This repository contains a small example of how to connect to a Qdrant
vector database as part of a retrieval augmented generation (RAG) system.
The `Code/qdrant_rag_connection.py` script reads connection settings from
a `.env` file using [`python-dotenv`](https://pypi.org/project/python-dotenv/)
and instantiates a `QdrantClient` from the [`qdrant-client`](https://pypi.org/project/qdrant-client/) package.

Create a `.env` file in the project root with the following variables:

```bash
QDRANT_URL=<http://localhost:6333>
QDRANT_API_KEY=<your-api-key-if-needed>
```

Install the required packages and run the script:

```bash
pip install qdrant-client python-dotenv
python Code/qdrant_rag_connection.py
```

The script performs a simple liveness check to verify that Qdrant is
reachable.
