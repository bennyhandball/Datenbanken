import os
from tempfile import NamedTemporaryFile

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

COLLECTION_NAME = "webapp_collection"


@app.route("/")
def index():
    chat_history = session.get("chat_history", [])
    return render_template("index.html", answer=None, error=None, chat_history=chat_history)


@app.route("/upload", methods=["POST"])
def upload():
    file = request.files.get("document")
    if file and file.filename:
        client = get_qdrant_client()
        filename = secure_filename(file.filename)
        with NamedTemporaryFile(delete=False, suffix=os.path.splitext(filename)[1]) as tmp:
            file.save(tmp.name)
            chunks = load_pdf_and_chunk(tmp.name)
            embeddings = embed_chunks(chunks)
            store_embeddings_in_qdrant(client, COLLECTION_NAME, chunks, embeddings)
        os.remove(tmp.name)
    return redirect(url_for("index"))


@app.route("/query", methods=["POST"])
def query():
    query_text = request.form.get("query", "")
    answer = None
    error = None
    chat_history = session.get("chat_history", [])
    if query_text:
        client = get_qdrant_client()
        try:
            retrieved = retrieve_similar_chunks(query_text, client, COLLECTION_NAME, top_k=5)
            answer = answer_with_context(query_text, retrieved)
            chat_history.append({"role": "user", "content": query_text})
            chat_history.append({"role": "assistant", "content": answer})
            session["chat_history"] = chat_history
        except ValueError as e:
            error = str(e)
    return render_template("index.html", answer=answer, error=error, chat_history=chat_history)


@app.route("/respond", methods=["POST"])
def respond():
    user_response = request.form.get("response", "")
    chat_history = session.get("chat_history", [])
    answer = None
    if user_response:
        client = get_qdrant_client()
        retrieved = retrieve_similar_chunks(user_response, client, COLLECTION_NAME, top_k=5)
        history_text = "\n".join(
            f"{msg['role'].capitalize()}: {msg['content']}" for msg in chat_history
        )
        context_chunks = retrieved + [history_text]
        answer = answer_with_context(user_response, context_chunks)
        chat_history.append({"role": "user", "content": user_response})
        chat_history.append({"role": "assistant", "content": answer})
        session["chat_history"] = chat_history
    return render_template(
        "index.html",
        answer=answer,
        error=None,
        chat_history=chat_history,
    )


if __name__ == "__main__":
    app.run(debug=True)
