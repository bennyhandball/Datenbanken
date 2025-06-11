#import "acronyms.typ": acronyms 
#import "acronym-lib.typ": init-acronyms, print-acronyms, acr, acrpl, acrs, acrspl, acrl, acrlpl, acrf, acrfpl

#import "variables.typ": variables
#import "variables-lib.typ": init-variables, print-variables, var, varpl, vars, varspl, varl, varlpl, varf,varfpl

#let embedding-modelle = [
== Embedding-Modelle

Embedding-Modelle spielen eine zentrale Rolle im #acr("ML"), insbesondere in #acr("RAG")-Architekturen #cite(<aws_embeddings_ml>). Sie dienen dazu, Wörter, Sätze oder Dokumente in dichte, numerische Vektoren zu transformieren, die semantische Beziehungen im hochdimensionalen Raum abbilden #cite(<coursera_embedding_model_2025>). Sie lösen das Problem, dass Computer nicht direkt mit Wörtern arbeiten können, sondern numerische Repräsentationen benötigen. Embeddings übersetzen Wörter, Sätze oder ganze Dokumente in hochdimensionale Vektorräume, wobei semantische Beziehungen erhalten bleiben #cite(<aws_embeddings_ml>). 




@Embeddings zeigt eine stark vereinfachte Übersicht über den Embedding Prozess. Dieser Prozess soll detailliert im folgenden #box[erläutert werden.]

#figure(caption:"Übersicht Prozess Embedding Modelle"+ " "+cite(<2024vector_embeddings>)+". ",image(width: 90%,"pictures/How-Embeddings-Work.jpg"))<Embeddings>

Die Umwandlung eines Wortes eines Satzes oder eines Dokuments in einen hochdimensionalen Vektor erfolgt nach folgendem Grundprinzip:

+ *Tokenisierung:* Die Tokenisierung teilt sich in zwei wesentlichr Phasen: die Textbereinigung und die eigentliche Token-Extraktion. Zunächst wird der Text von irrelevanten Elementen bereinigt. Dazu zählen HTML-Tags, URLs, E-Mail-Adressen, Emojis, Sonderzeichen sowie überflüssige Leerzeichen oder Zeilenumbrüche. Optional kann der gesamte Text in Kleinbuchstaben konvertiert werden, um die Konsistenz zu erhöhen. Anschließend wird der bereinigte Text in einzelne Tokens (Einheiten) zerlegt. Unter einem Token versteht man dabei die kleinste bedeutungstragende Einheit, in die ein Text während der Verarbeitung durch ein Sprachmodell zerlegt wird. Was dabei genau als Token gilt, hängt vom Modell und der Tokenisierungsstrategie ab. 

+ *Embedding-Zuordnung:* In diesem Schritt wird jedem Token eine numerische Repräsentation in Form eines hochdimensionalen Vektors zugewiesen. Dies erfolt über eine Lookup-Operation in der Embedding-Matrix, einer vortrainierten Tabelle, die für jedes Token im Vokabular einen entsprechenden Vektor bereithält.  

+ *Vektorraum und semantische Beziehungen:* Die generierten Embedding-Vektoren spannen einen hochdimensionalen Vektor auf, in dem semantische Beziehungen zwischen Wörtern durch geometrische Relationen repräsentiert werden. Semantisch ähnliche Wörter befinden sich in diesem Raum in räumlicher Nähe zueinander. Diese Eigenschaft ermöglicht es, semantische Ähnlichkeiten durch Vektoroperationen (Kosinus-Ähnlichkeit) zu erfassen. 

+ *Pooling/Aggregation:* Da längere Texte aus mehreren Tokens bestehen, müssen die individuellen Token-Vektoren zu einer einheitlichen Repräsentation für den gesamten Text aggrigiert werden. Hierfür können verschiedene Pooling-Strategien genutzt werden. 

+ *Normalisierung:* In diesem Schritt sollen die Embeddings vergleichbar gemacht werden 
]
