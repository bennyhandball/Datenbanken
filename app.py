import os
from tempfile import NamedTemporaryFile

from flask import Flask, render_template, request
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


@app.route("/", methods=["GET", "POST"])
def index():
    answer = None
    if request.method == "POST":
        file = request.files.get("document")
        query = request.form.get("query", "")
        client = get_qdrant_client()

        if file and file.filename:
            filename = secure_filename(file.filename)
            with NamedTemporaryFile(delete=False, suffix=os.path.splitext(filename)[1]) as tmp:
                file.save(tmp.name)
                chunks = load_pdf_and_chunk(tmp.name)
                embeddings = embed_chunks(chunks)
                store_embeddings_in_qdrant(client, COLLECTION_NAME, chunks, embeddings)
            os.remove(tmp.name)

        if query:
            retrieved = retrieve_similar_chunks(query, client, COLLECTION_NAME, top_k=5)
            answer = answer_with_context(query, retrieved)

    return render_template("index.html", answer=answer)


if __name__ == "__main__":
    app.run(debug=True)
