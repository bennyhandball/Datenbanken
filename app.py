import os
from tempfile import NamedTemporaryFile

from flask import Flask, render_template, request, redirect, url_for
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
app.config["MAX_CONTENT_LENGTH"] = 16 * 1024 * 1024  # 16 MB limit

COLLECTION_NAME = "webapp_collection"


@app.route("/")
def index():
    return render_template("index.html", answer=None, error=None)


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
    if query_text:
        client = get_qdrant_client()
        try:
            retrieved = retrieve_similar_chunks(query_text, client, COLLECTION_NAME, top_k=5)
            answer = answer_with_context(query_text, retrieved)
        except ValueError as e:
            error = str(e)
    return render_template("index.html", answer=answer, error=error)


if __name__ == "__main__":
    app.run(debug=True)
