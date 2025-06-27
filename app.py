import os
import time
from tempfile import NamedTemporaryFile
from datetime import datetime

from flask import Flask, render_template, request, redirect, url_for, session
from werkzeug.utils import secure_filename

from Code.qdrant_utils import (
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
    return render_template("index.html", answer=None, error=None, chat_history=chat_history)


@app.route("/clear_chat", methods=["POST"])
def clear_chat():
    """Clear the current chat history."""
    session.clear()
    return redirect(url_for("index"))


@app.route("/interact", methods=["POST"])
def interact():
    check_server_restart()
    file = request.files.get("document")
    message = request.form.get("message", "").strip()

    answer = None
    error = None
    chat_history = session.get("chat_history", [])

    if file and file.filename:
        client = get_qdrant_client()
        filename = secure_filename(file.filename)
        with NamedTemporaryFile(delete=False, suffix=os.path.splitext(filename)[1]) as tmp:
            file.save(tmp.name)
            chunks = load_pdf_and_chunk(tmp.name)
            embeddings = embed_chunks(chunks)
            store_embeddings_in_qdrant(client, COLLECTION_NAME, chunks, embeddings)
        os.remove(tmp.name)

    if message:
        client = get_qdrant_client()
        try:
            # Retrieve context for the current question
            retrieved = retrieve_similar_chunks(message, client, COLLECTION_NAME, top_k=5)

            # Additionally look up the previous user message when available
            previous_user_message = None
            for past in reversed(chat_history):
                if past.get("role") == "user":
                    previous_user_message = past.get("content")
                    break

            if previous_user_message:
                retrieved_prev = retrieve_similar_chunks(
                    previous_user_message, client, COLLECTION_NAME, top_k=5
                )
                retrieved.extend(retrieved_prev)

            if len(chat_history) > 1:
                history_text = "\n".join(
                    f"{msg['role'].capitalize()}: {msg['content']}" for msg in chat_history
                )
                context_chunks = retrieved + [history_text]
                answer = answer_with_context(message, context_chunks)
            else:
                answer = answer_with_context(message, retrieved)

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

    return render_template("index.html", answer=answer, error=error, chat_history=chat_history)


if __name__ == "__main__":
    app.run(debug=True)
