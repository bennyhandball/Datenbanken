#import "acronyms.typ": acronyms 
#import "acronym-lib.typ": init-acronyms, print-acronyms, acr, acrpl, acrs, acrspl, acrl, acrlpl, acrf, acrfpl

#import "variables.typ": variables
#import "variables-lib.typ": init-variables, print-variables, var, varpl, vars, varspl, varl, varlpl, varf,varfpl

#let evaluation_and_deployment = [
== Evaluation <Evaluation>
Die Ergebnisse aus @Modelling wurden erfasst und in tabellarischer Form gesammelt. Anschließend wurden diese mit den in @EvaluationParameters definierten Metriken ausgewertet. @aggregated_metrics präsentiert die über alle Fragen hinweg aggregierten Resultate, differenziert nach N-Gramm-basierten Metriken und #acr("LLM")-as-a-Judge-Bewertungen. Die Ergebnisse je Frage befinden sich in @evaluation_total_results im Anhang.
  
#figure(caption:
[Aggregierte Metriken vor/nach #acr("RAG")-Implementierung. Eigene Darstellung.]
, image(
"pictures/metrics_aggregated.png" 
))
<aggregated_metrics>

@aggregated_metrics zeigt, dass beide Metriktypen eine signifikante Steigerung der Antwortqualität infolge der #acr("RAG")-Implementierung verzeichnen. So erhöht sich beispielsweise die durchschnittliche Precision-1 von 15,5 % auf 32,6 %, Recall-1 von 8,6 % auf 32,4 % und #acr("ROUGE")-1 von 11,2 % auf 29,1 %. Ähnliche Verbesserungen sind bei den 2-Gramm-Metriken zu beobachten (Precision-2: +8,8 #acr("pp"), Recall-2: +11,1 #acr("pp"), ROUGE-2: +9,0 #acr("pp")). 

Die #acr("LLM")-as-a-Judge-Bewertungen stützen dieses Ergebnis: Während das Baselinesystem in vier von fünf Dimensionen durchschnittlich 0 von 2 Punkten erreicht, erzielt das #acr("RAG")-System signifikant höhere Werte (1,7 für Faktentreue, 1,2 für Vollständigkeit, 2,0 für Relevanz, 1,3 für Begründung und 1,2 für Tiefe, vgl. @heatmap_judge). Dies unterstreicht sowohl eine quantitativ als auch qualitativ verbesserte Antwortgenerierung durch #acr("RAG").

Bei der Betrachtung der Ergebnisse auf Ebene der einzelnen Fragen (siehe @heatmap_n_grams und @heatmap_judge) zeigt sich, dass die Verbesserungen nicht gleichmäßig verteilt sind. Einige Fragen profitieren stark von der RAG-Implementierung, während andere nur geringe oder gar keine Verbesserungen zeigen. Dies könnte auf unterschiedliche Schwierigkeitsgrade der Fragen oder auf die Verfügbarkeit relevanter Dokumente zurückzuführen sein. 

#figure(caption:
[Vergleich der Metriken je Fragenart. Eigene Darstellung.]
, image(width: 80%,
"pictures/metrics_META_nonMETA.png" 
))
<metrics_META_nonMETA>

@metrics_META_nonMETA verdeutlicht, dass insbesondere Anfragen mit Metadateninhalten stark vom #acr("RAG")-gestützten System profitieren, selbst wenn die N-Gramm-Metriken insgesamt geringer ausfallen. Dies unterstreicht, dass #acr("RAG") Metadaten, welche im Vergleich zu Inhaltsfragen einehitlichere Struktur aufweisen, besser verarbeiten kann als spezifische Inhaltsfragen

@correlation_metrics illustriert die Korrelationsbeziehung zwischen den N-Gramm-Metriken und den #acr("LLM")-as-a-Judge-Bewertungen, wobei letztere zur besseren Vergleichbarkeit als Anteil am Maximalscore (2 Punkte) normalisiert wurden. Dafür wird der #varl("r") #vars("r") verwendet, welcher die lineare Beziehung zwischen zwei Variablen misst. $abs(#vars("r"))=1$ bedeutet eine perfekte Korrelation, während $abs(#vars("r"))=0$ keine Korrelation anzeigt.
  #cite(<cohen1988statistical>, supplement: "S. 75-79")

Die Analyse offenbart eine moderate positive Korrelation zwischen beiden Bewertungsansätzen: Mit steigenden N-Gramm-Werten nehmen tendenziell auch die #acr("LLM")-Bewertungen zu. Bemerkenswert ist die asymmetrische Bewertungscharakteristik des #acr("LLM"): Qualitativ unzureichende Antworten werden verstärkt negativ bewertet $(#vars("r") = –0.21)$, während besonders hohe N-Gramm-Scores überproportional positiv honoriert werden $(#vars("r") = 0.44)$. Diese Beobachtung unterstreicht den komplementären Charakter der #acr("LLM")-basierten Evaluation zu den rein quantitativen Metriken.

#figure(caption:
[Korrelation zwischen N-Gramm/LLM-as-a-Judge. Eigene Darstellung.]
, image(width: 80%,
"pictures/correlation_judge_n_grams.png" 
))
<correlation_metrics>

Zusammenfassend belegen die Ergebnisse eine signifikante Verbesserung der Antwortqualität durch den Einsatz von #acr("RAG"). Die Kombination aus N-Gramm-basierten Metriken und #acr("LLM")-as-a-Judge-Bewertungen ermöglicht eine robuste Einschätzung des qualitativen Mehrwerts. Im Anschluss wird ein Chatbot-Deployment vorgestellt, das eine #acr("RAG")-basierte Abfrage über eine Vektordatenbank ermöglicht.

#pagebreak()

== Deployment <Deployment>

Aufgrund der positiven Ergebnisse in @Evaluation wird im Rahmen dieser Arbeit ein Prototyp angefertigt, welcher folgende Funktionalitäten bietet:

- *Datenpflege:* Nutzer können Dokumente in einer Vektordatenbank speichern, die für #acr("RAG")-Abfragen genutzt werden.
- *Abfrage von Inhalten:* In einem Chat können Nutzer Fragen stellen, die das System mit Hilfe von #acr("RAG") beantwortet. Dabei werden relevante Dokumente aus der Vektordatenbank abgerufen und die Antworten generiert.
- *Übersicht hochgeladener Dokumente:* Unter dem Chat werden die hochgeladenen Dokumente aufgelistet, die für die #acr("RAG")-Abfrage genutzt werden.

Der Prototyp nutzt Flask als Web-Framework und Qdrant als Vektordatenbank. Aufgrund der positiven Ergebnisse aus @Evaluation wurde die in @Modelling vorgestellte Architektur sowie identischen Modelle eingesetzt. Die 

#figure(caption:
[Korrelation zwischen N-Gramm/LLM-as-a-Judge. Eigene Darstellung.]
, image(width: 65%,
"pictures/prototype.png" 
))
<prototype>

Wie aus @prototype ersichtlich können Nutzer Dokumente hochladen, die dann in der Vektordatenbank gespeichert werden. Anschließend können sie im Chat Fragen stellen, auf die das System mit Hilfe von #acr("RAG") antwortet und Informationen in Form einer Nachricht zurückgibt. Unter dem Chat werden hochgeladene Dokumente aufgelistet, die für die #acr("RAG")-Abfrage genutzt werden.

Im Folgenden wird in der Schlussbetrachtung auf die Ergebnisse der Arbeit eingegangen, diese hinsichtlich ihrer Herausforderungen und Limitationen diskutiert ein Ausblick zur weiteren Forschung betrachtet.

]