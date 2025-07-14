#import "acronyms.typ": acronyms 
#import "acronym-lib.typ": init-acronyms, print-acronyms, acr, acrpl, acrs, acrspl, acrl, acrlpl, acrf, acrfpl

#import "variables.typ": variables
#import "variables-lib.typ": init-variables, print-variables, var, varpl, vars, varspl, varl, varlpl, varf,varfpl

#let embedding-modelle = [
== Embedding-Modelle

Embedding-Modelle spielen eine zentrale Rolle im ML, insbesondere in RAG-Architekturen. Sie transformieren Wörter, Sätze oder Dokumente in dichte, numerische Vektoren, die semantische Beziehungen im hochdimensionalen Raum abbilden. Da Computer nicht direkt mit Wörtern arbeiten können, übersetzen Embeddings textuelle Inhalte in Vektorräume, wobei semantische Beziehungen erhalten bleiben. @Embeddings zeigt eine vereinfachte Übersicht über den Embedding-Prozess, der im folgenden detailliert erläutert wird.

#figure(caption:"Übersicht Prozess Embedding Modelle"+ " "+cite(<2024vector_embeddings>)+". ",image(width: 86%,"pictures/How-Embeddings-Work.jpg"))<Embeddings>

Die Umwandlung eines Wortes eines Satzes oder eines Dokuments in einen hochdimensionalen Vektor erfolgt nach folgendem Grundprinzip:

+ *Tokenisierung:* Die Tokenisierung teilt sich in zwei wesentliche Phasen: die Textbereinigung und die eigentliche Token-Extraktion. Zunächst wird der Text von irrelevanten Elementen bereinigt. Dazu zählen HTML-Tags, URLs, E-Mail-Adressen, Emojis, Sonderzeichen sowie überflüssige Leerzeichen oder Zeilenumbrüche. Optional kann der gesamte Text in Kleinbuchstaben konvertiert werden, um die Konsistenz zu erhöhen. Anschließend wird der bereinigte Text in einzelne Tokens (Einheiten) zerlegt. Unter einem Token versteht man dabei die kleinste bedeutungstragende Einheit, in die ein Text während der Verarbeitung durch ein Sprachmodell zerlegt wird. Was dabei genau als Token gilt, hängt vom Modell und der Tokenisierungsstrategie ab #cite(<AttentionIsAllYouNeed>, supplement: "S.3-6").

+ *Embedding-Zuordnung:* In diesem Schritt wird jedem Token eine numerische Repräsentation in Form eines hochdimensionalen Vektors zugewiesen. Dies erfolgt über eine Lookup-Operation in der Embedding-Matrix, einer vortrainierten Tabelle, die für jedes Token im Vokabular einen entsprechenden Vektor bereithält. Die Embedding-Matrix entsteht durch das Training auf großen Textkorpora mittels Algorithmen wie Word2Vec, GloVe oder FastText #cite(<AttentionIsAllYouNeed>, supplement: "S.3-6").

+ *Vektorraum und semantische Beziehungen:* Die generierten Embedding-Vektoren spannen einen hochdimensionalen Vektorraum auf, in dem semantische Beziehungen zwischen Wörtern durch geometrische Relationen repräsentiert werden. Semantisch ähnliche Wörter befinden sich in diesem Raum in räumlicher Nähe zueinander. Diese Eigenschaft ermöglicht es, semantische Ähnlichkeiten durch Vektoroperationen (Kosinus-Ähnlichkeit) zu erfassen. Darüber hinaus können durch Vektorarithmetik komplexe Beziehungen modelliert werden, wie beispielsweise die bekannte Analogie "König - Mann + Frau ≈ Königin" #cite(<AttentionIsAllYouNeed>, supplement: "S.3-6").

+ *Pooling/Aggregation:* Da längere Texte aus mehreren Tokens bestehen, müssen die individuellen Token-Vektoren zu einer einheitlichen Repräsentation für den gesamten Text aggregiert werden. Hierfür können verschiedene Pooling-Strategien genutzt werden. Average Pooling berechnet den Durchschnitt aller Token-Vektoren, während Max Pooling die maximalen Werte jeder Dimension über alle Token verwendet. Min Pooling wählt entsprechend die minimalen Werte aus #cite(<AttentionIsAllYouNeed>, supplement: "S.3-6").

+ *Normalisierung:* In diesem Schritt werden die Embeddings vergleichbar gemacht, um eine einheitliche Skalierung zu gewährleisten. Die Standardmethode ist die L2-Normalisierung, die jeden Vektor so anpasst, dass seine euklidische Länge (L2-Norm) 1 wird. Dies geschieht durch Division jeder Komponente des Vektors durch die ursprüngliche L2-Norm des Vektors. Die Normalisierung ermöglicht es, dass die Kosinus-Ähnlichkeit als Maß für semantische Ähnlichkeit verwendet werden kann, da normalisierte Vektoren die gleiche Länge haben und somit nur ihre Richtung im Vektorraum relevant ist #cite(<AttentionIsAllYouNeed>, supplement: "S.3-6").

]
