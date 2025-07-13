import os
import time
import json
from tempfile import NamedTemporaryFile
from datetime import datetime

from flask import Flask, render_template, request, redirect, url_for, session
from werkzeug.utils import secure_filename

from Experiment.qdrant_utils import (
    get_qdrant_client,
    load_pdf_and_chunk,
    embed_chunks,
    store_embeddings_in_qdrant,
    retrieve_similar_chunks,
    answer_with_context,
)

app = Flask(__name__)
app.secret_key = os.getenv("FLASK_SECRET_KEY", "dev-secret")
app.config["MAX_CONTENT_LENGTH"] = 16 * 1024 * 1024  # 16 MB limit
app.config["SERVER_START_TIME"] = time.time()

COLLECTION_NAME = "webapp_collection"
# Path to the JSON registry of uploaded filenames
REGISTRY_PATH = os.path.join(app.root_path, 'uploaded_docs.json')


def load_uploaded_docs():
    """Read the JSON registry, return list of filenames."""
    if not os.path.exists(REGISTRY_PATH):
        return []
    with open(REGISTRY_PATH, 'r', encoding='utf-8') as f:
        try:
            return json.load(f)
        except json.JSONDecodeError:
            return []


def save_uploaded_docs(docs):
    """Write the list of filenames back to the registry."""
    with open(REGISTRY_PATH, 'w', encoding='utf-8') as f:
        json.dump(docs, f, indent=2, ensure_ascii=False)


def check_server_restart():
    """Reset session if the server has been restarted."""
    if session.get("server_start_time") != app.config["SERVER_START_TIME"]:
        session.clear()
        session["server_start_time"] = app.config["SERVER_START_TIME"]
        session["chat_history"] = [
            {
                "role": "assistant",
                "content": "Hi, wie kann ich Dir heute helfen ?",
                "timestamp": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            }
        ]


@app.route("/")
def index():
    check_server_restart()
    chat_history = session.get("chat_history", [])
    uploaded_docs = load_uploaded_docs()
    return render_template(
        "index.html",
        chat_history=chat_history,
        uploaded_docs=uploaded_docs,
        answer=None,
        error=None
    )


@app.route("/clear_chat", methods=["POST"])
def clear_chat():
    """Clear the current chat history."""
    session.clear()
    return redirect(url_for("index"))


@app.route("/interact", methods=["GET", "POST"])
def interact():
    if request.method == "GET":
        return redirect(url_for("index"))

    check_server_restart()
    file = request.files.get("document")
    message = request.form.get("message", "").strip()

    answer = None
    error = None
    chat_history = session.get("chat_history", [])

    # ---- Handle file upload ----
    if file and file.filename:
        # save to Qdrant and temporarily to disk
        client = get_qdrant_client()
        filename = secure_filename(file.filename)
        # 1) Save temporarily
        with NamedTemporaryFile(delete=False, suffix=os.path.splitext(filename)[1]) as tmp:
            file.save(tmp.name)
            chunks = load_pdf_and_chunk(tmp.name)
            embeddings = embed_chunks(chunks)
            store_embeddings_in_qdrant(client, COLLECTION_NAME, chunks, embeddings)
        os.remove(tmp.name)

        # 2) Append filename to registry (if new)
        docs = load_uploaded_docs()
        if filename not in docs:
            docs.append(filename)
            save_uploaded_docs(docs)

    # ---- Handle chat message ----
    if message:
        client = get_qdrant_client()
        try:
            # Retrieve context for the current question
            retrieved = retrieve_similar_chunks(message, client, COLLECTION_NAME, top_k=5)
            # Also retrieve context for all past user messages
            for past in chat_history:
                if past.get("role") == "user":
                    retrieved += retrieve_similar_chunks(
                        past.get("content"), client, COLLECTION_NAME, top_k=5
                    )

            # Build answer
            if len(chat_history) > 1:
                history_text = "\n".join(
                    f"{msg['role'].capitalize()}: {msg['content']}"
                    for msg in chat_history
                )
                context = retrieved + [history_text]
            else:
                context = retrieved

            answer = answer_with_context(message, context)

            # Update chat history
            chat_history.append({
                "role": "user",
                "content": message,
                "timestamp": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            })
            chat_history.append({
                "role": "assistant",
                "content": answer,
                "timestamp": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            })
            session["chat_history"] = chat_history

        except ValueError as e:
            error = str(e)

    # Re-load uploaded docs so the template always sees the latest
    uploaded_docs = load_uploaded_docs()
    return render_template(
        "index.html",
        chat_history=chat_history,
        uploaded_docs=uploaded_docs,
        answer=answer,
        error=error
    )


if __name__ == "__main__":
    app.run(debug=True)