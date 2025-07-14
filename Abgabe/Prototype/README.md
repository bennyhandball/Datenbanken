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

## Web Interface

The repository contains a small Flask application in `app.py` for uploading
PDFs and submitting questions. Uploaded documents are chunked, embedded and
stored in Qdrant. Questions can then be asked against this vector store.
The web interface uses a **single** form that lets you upload a PDF document,
send a query and optionally reply to the generated answer. Each interaction is
added to a persistent chat history which is shown in a ChatGPT-style layout with
distinct user and assistant bubbles. A simple loading bar gives visual feedback
while the application processes a request, and the chat area automatically
scrolls to the latest message after each interaction. The chat history is also
sent as additional context for follow-up questions. When processing a new
query, the application now retrieves additional context for **all** previous
user messages by issuing lookups against Qdrant for each of them.

When the server restarts the session history is reset. After a restart the chat
shows a single assistant message prompting the user to ask a question.


To
run the web app install the dependencies and start the server:

```bash
pip install -r requirements.txt
python app.py
```

Ensure the `.env` file contains the required `QDRANT_SERVER_IP`,
`QDRANT_PORT` and optionally `OPENAI_API_KEY` variables. When no OpenAI key is
set the application will fall back to simple local embeddings and return the
retrieved context directly.
The app will be available at
`http://localhost:5000/`.
