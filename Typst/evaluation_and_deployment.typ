#import "acronyms.typ": acronyms 
#import "acronym-lib.typ": init-acronyms, print-acronyms, acr, acrpl, acrs, acrspl, acrl, acrlpl, acrf, acrfpl

#import "variables.typ": variables
#import "variables-lib.typ": init-variables, print-variables, var, varpl, vars, varspl, varl, varlpl, varf,varfpl

#let evaluation_and_deployment = [
== Evaluation <Evaluation>
  
#figure(caption:
[Aggregierte Metriken des entwickelten #acr("RAG")-Systems]
, image(
"pictures/metrics_aggregated.png" 
))
<aggregated_metrics>

@aggregated_metrics zeigt die Ergebnisse der Evaluation des entwickelten #acr("RAG")-Systems. Die Metriken wurden aggregiert, um einen Überblick über die Leistung des Systems zu geben. Die Ergebnisse zeigen, dass das System in der Lage ist, qualitativ hochwertige Antworten auf gestellte Fragen zu liefern.

#figure(caption:
[Phasen des CRISP-DM Phasenmodells @wirth_hipp_2000 ]
, image(width: 50%,
"pictures/total_passes.png" 
))
<total_passes>

== Deployment <Deployment>

]