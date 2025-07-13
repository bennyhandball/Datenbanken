#import "acronyms.typ": acronyms 
#import "acronym-lib.typ": init-acronyms, print-acronyms, acr, acrpl, acrs, acrspl, acrl, acrlpl, acrf, acrfpl

#import "variables.typ": variables
#import "variables-lib.typ": init-variables, print-variables, var, varpl, vars, varspl, varl, varlpl, varf,varfpl

#let evaluation_and_deployment = [
== Evaluation <Evaluation>
  
#figure(caption:
[Aggregierte Metriken vor/nach #acr("RAG")-Implementierung. Eigene Darstellung.]
, image(
"pictures/metrics_aggregated.png" 
))
<aggregated_metrics>

@aggregated_metrics zeigt die aggregierten Ergebnisse über alle Fragen hinweg, aufgeteilt in N-Gramm basierte Daten und #acr("LLM")-as-a-Judge Metriken....

#figure(caption:
[Phasen des CRISP-DM Phasenmodells @wirth_hipp_2000 ]
, image(width: 50%,
"pictures/total_passes.png" 
))
<total_passes>

== Deployment <Deployment>

]