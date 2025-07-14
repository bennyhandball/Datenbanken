#import "acronyms.typ": acronyms 
#import "acronym-lib.typ": init-acronyms, print-acronyms, acr, acrpl, acrs, acrspl, acrl, acrlpl, acrf, acrfpl

#import "variables.typ": variables
#import "variables-lib.typ": init-variables, print-variables, var, varpl, vars, varspl, varl, varlpl, varf,varfpl

#let rag_parameter = [

#pagebreak()
=== Retrieval-Augmented-Generation Parameter

Die Leistung eines #acr("RAG")-Systems werden durch die Wahl mehrerer Parameter beeinflusst. Jeder Parameter wirkt sowohl eigenständig als auch in Wechselwirkung mit den anderen. Folgende Parameter sind von #box("besonderer Relevanz:")

- *#acr("LLM")*: Das verwendete #acr("LLM") zur Generierung von Antworten auf Fragen beeinflusst Genauigkeit und Kohärenz der Antwort. Je nach Komplexität der Aufgabe eignen sich verschiedene Modelle unterschiedlich gut, wodurch deren Auswahl entscheidend ist und in Abhängigkeit von Domäne und Rahmenbedingungen variiert #box("werden sollte. "+cite(<lewis2020rag>, supplement: "S. "))
- *Embedding-Modell*: Die Wahl des Embedding-Modells beeinflusst das Retrieval von notwendigen Informationen #cite(<openai2025embeddingmodels>). Präzise Embeddings verbessern das Ranking relevanter Chunks und verringern Halluzinationen im Zusammenspiel mit #box("dem "+acr("LLM")+" "+cite(<qu2024semantic>, supplement: "S. 2-3")+".")
- *Chunkgröße*: Die Chunkgröße legt fest, wie lang die einzelnen Textabschnitte sind, die vor der Umwandlung in Vektoren segmentiert werden. Kleinere Chunks erhöhen Präzision, wobei große Chunks den Zusammenhang bewahren. Ein optimales Verhältnis entsteht durch Ausbalancieren von Kontextumfang, irrelevanter Informationen und #box("Kontextnutzung im "+acr("LLM")+". "+cite(<juvekar2024context>, supplement: "S. 1"))
- *Overlap*: Overlap bezeichnet die Anzahl der überlappenden Tokens zweier aufeinanderfolgender Chunks und zielt darauf ab, Kontextverluste an Chunk-Grenzen zu vermeiden #cite(<lewis2020rag>, supplement: "S. "). Ein ausreichender Overlap erhöht die Wahrscheinlichkeit, dass relevante Informationen nicht zwischen zwei Chunks verloren gehen, wobei damit ein erhöhter Ressourcenaufwand und #box("Redundanz einhergeht "+cite(<qu2024semantic>, supplement: "S. 2")+".")
- *Top-k-Retrieval Parameter*: Definiert, die #varf("k") die bei einer Abfrage vom #acr("RAG")-System zurückgegeben werden. Ein niedriger Wert kann relevante Ergebnisse ausschließen, während ein zu hoher Wert irrelevante Informationen #box("mit einbezieht. "+cite(<lewis2020rag>, supplement: "S. 2"))

]