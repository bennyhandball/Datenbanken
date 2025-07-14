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

@aggregated_metrics zeigt die aggregierten Ergebnisse über alle Fragen hinweg, aufgeteilt in N-Gramm basierte Daten und #acr("LLM")-as-a-Judge Metriken....

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