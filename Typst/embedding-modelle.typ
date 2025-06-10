#import "acronyms.typ": acronyms 
#import "acronym-lib.typ": init-acronyms, print-acronyms, acr, acrpl, acrs, acrspl, acrl, acrlpl, acrf, acrfpl

#import "variables.typ": variables
#import "variables-lib.typ": init-variables, print-variables, var, varpl, vars, varspl, varl, varlpl, varf,varfpl

#let embedding-modelle = [
== Embedding-Modelle

Embedding-Modelle spielen eine zentrale Rolle im #acr("NLP"), insbesondere in #acr("RAG")-Architekturen. Sie dienen dazu, Wörter, Sätze oder Dokumente in dichte, numerische Vektoren zu transformieren, die semantische Beziehungen im hochdimensionalen Raum abbilden. 
#v(1.5em)
Neuronale Netzwerke können Wörter, Sätze oder Dokumente nicht direkt verarbeiten. Um eine Verarbeitung zu ermöglichen, ist eine Umwandlung in eine Abbildung durch einen Vektor nötig. Die Umwandlung eines Wortes eines Satzes oder eines Dokuments in einen hochdimensionalen Vektor erfolgt nach folgendem Grundprinzip:
#v(1em)
+ *Tokenisierung:* Zunächst wird der Text von irrelevanten Elementen bereinigt. Dazu zählen HTML-Tags, URLs, E-Mail-Adressen, Emojis, Sonderzeichen sowie überflüssige Leerzeichen oder Zeilenumbrüche. Optional kann der gesamte Text in Kleinbuchstaben konvertiert werden, um die Konsistenz zu erhöhen. Anschließend wird der bereinigte Text in einzelne Tokens (Einheiten) zerlegt. Unter einem Token versteht man dabei die kleinste bedeutungstragende Einheit, in die ein Text während der Verarbeitung durch ein Sprachmodell zerlegt wird. Was dabei genau als Token gilt, hängt vom Modell und der Tokenisierungsstrategie ab. 
  
+ *Embedding-Zuordnung:* In diesem Schritt wird jedem Token eine numerische Repräsentation (Vektor) zugewiesen. 

+ *Vektorraum* 

+ *Pooling/Aggregation:* Einzelne Token-Vektoren werden zu einem Gesamtvektor für den gesamten Text zusammengefasst.

+ *Normalisierung:* In diesem Schritt sollen die Embeddings vergleichbar gemacht werden 
]