#import "acronyms.typ": acronyms 
#import "acronym-lib.typ": init-acronyms, print-acronyms, acr, acrpl, acrs, acrspl, acrl, acrlpl, acrf, acrfpl

#import "variables.typ": variables
#import "variables-lib.typ": init-variables, print-variables, var, varpl, vars, varspl, varl, varlpl, varf,varfpl

#let rag_evaluation = [
== Retrieval Augmented Generation Evaluation

Um die Leistung eines #acr("RAG")-Systems messbar zu machen, werden geeignete Evaluationsmetriken bestimmt. Diese spalten sich in Klassifikationsmetriken, zur Klassifizierung richtiger und falscher Ergebnisse, sowie Token-Similarity-Metriken zum Vergleich der Ähnlichkeit von Referenz- und #acr("LLM")-Antwort.
  #cite(<Hu2024LLMEvaluation>, supplement: "S. 6-7")

Bei der Klassifizierung werden Daten in eine oder mehrere Klassen zugeordnet und anhand einer Referenzklassifizierung evaluiert
  #cite(<Hu2024LLMEvaluation>, supplement: "S. 6").
Hierbei wird zwischen Einfach- und Mehrfach-Klassifizierung unterscheiden. Bei Einfach-Klassifizierung wird einem Datensatz eine Klasse zugeordnet, bei Mehrfach-Klassifizierung können einem Datensatz mehrere Klassen zugeordnet werden.

Token-Similarity Metriken evaluieren Wortsequenzen. Dafür werden Metriken wie #acrf("ROUGE") eingesetzt, die eine Wortsequenz gegenüber einer Referenzquelle evaluiert und anhand der Überschneidung einen #box([Wert bestimmt
  #cite(<Lin2004>, supplement: "S. 1-2").])

=== Precision, Recall und F1-Score <PrRecF1>
Precision, Recall und F1-Score sind drei weit verbreitete Metriken zur Evaluation von Klassifikationen durch ein Modell gegenüber einer Referenzquelle
  #cite(<Ghamrawi2005CollectiveMLC>, supplement: "S. 5"). 
Sie geben Aufschluss, inwiefern eine Modellklassifikation der #box([Referenzklassifikation entspricht
  #cite(<adamson2023ml_ehr>, supplement: "S. 6")
  #cite(<srivastava2024medpromptextract>, supplement: "S. 7-9")
  #cite(<Hein2025>, supplement: "S. 8").])

Sei $#vars("c")$ eine #varl("c"), $#vars("L")$ die #varl("L") ${#vars("c")_1, #vars("c")_2, ... #vars("c")_#vars("L")}$ inklusive der Null-Klasse $#vars("c")_\u{2205}$ bei fehlender Label-Zuweisung, $abs(#vars("L"))$ die Kardinalität der Menge $#vars("L")$, $#vars("P")\u{2286}#vars("L")$ die #varl("P") und $#vars("H")\u{2286}#vars("L")$ die #varl("H"). Bei $abs(#vars("L"))=1$ kann eine #acr("LLM")-Vorhersage als klassifiziert oder nicht klassifiziert angesehen werden, wodurch eine binäre Zuordnung in positiv und negativ erlaubt wird. Dies wird für $#vars("P")$ und $#vars("H")$ durchgeführt und den in @ConfusionMatrixOneDimensional dargestellten Mengen je #acr("LLM")-Vorhersage zugewiesen. Anhand dieser Mengen kann eine quantitative Bewertung der Klassifikation berechnet werden
  #cite(<Hu2024LLMEvaluation>, supplement: "S. 7-9").

  #figure(caption: "Confusion Matrix für eindimensionale Klassifizierung "+box("je Klasse " + cite(<Lipton2014Thresholding>, supplement: "S. 3")), table(
    columns: (auto, auto, auto),
    inset: 8pt,
    align: horizon,
    table.header(
      [],[*Tatsächlich positiv*], [*Tatsächlich negativ*],
    ),
    [#align(left)[*Als positiv klassifiziert*]],
      [$#varf("TP")$],
      [$#varf("TN")$],
    [#align(left)[*Als negativ klassifiziert*]],
      [$#varf("FP")$],
      [$#varf("FN")$],
    
  ))<ConfusionMatrixOneDimensional>

Precision gibt an, welcher Anteil der als positiv identifizierten Ergebnisse tatsächlich positiv ist. Sie misst die Fähigkeit eines #acrpl("LLM"), negative Instanzen zu filtern. Die Formel der Precision ist im Folgenden dargestellt. Hierbei entspricht $abs("Menge")$ der Kardinalität einer Menge: 
  #cite(<Hu2024LLMEvaluation>, supplement: "S. 8")

#align(center, [
  $ "Precision" 
  = "korrekt als positiv klassifizierte Einträge" / "als positiv klassifizierte Einträge" 
  = abs(#vars("TP")) / (abs(#vars("TP")) + abs(#vars("FP"))) $
])

Recall, auch bekannt als "True Positive Rate" oder "Sensitivity", beschreibt, wie vollständig relevante Ergebnisse erkannt wurden. Sie bestimmt, inwiefern ein Modell positive Ergebnisse identifiziert. Die Formel für Recall lautet:
  #cite(<Hu2024LLMEvaluation>, supplement: "S. 7-8")

#align(center, [
  $ "Recall" 
  = "korrekt als positiv klassifizierte Einträge" / "tatsächlich positive Einträge"
  = abs(#vars("TP")) / (abs(#vars("TP")) + abs(#vars("FN"))) $
])

Der F1-Score bildet das harmonische Mittel zwischen Precision und Recall. Die Formel für den F1-Score lautet:
  #cite(<Hu2024LLMEvaluation>, supplement: "S. 8")

#align(center, [
  $ "F1-Score" 
  = (2dot"Precision"dot"Recall") / ("Precision"+"Recall")
  = (2 dot abs(#vars("TP"))) / (2 dot abs(#vars("TP")) + abs(#vars("FP")) + abs(#vars("FN"))) $
])

=== Recall-Oriented Understudy for Gisting Evaluation <ROUGE>
#acr("ROUGE") ist eine Evaluationsmetrik des #acr("NLP"), welche zur Evaluation von generierten Texten gegenüber eines Referenztextes angewendet wird
  #cite(<Hu2024LLMEvaluation>, supplement: "S. 11-12").
Sie quantifiziert die Ähnlichkeit zweier Texte in einer Metrik und ermöglicht gegenüber Klassifikationsmetriken die Evaluation von Auswirkungen der Modellierung auf Freitexte
  #cite(<Hu2024LLMEvaluation>, supplement: "S. 14").
#acr("ROUGE")-n, eine Umsetzung von #acr("ROUGE"), misst den Überlappungsgrad zwischen einem generierten Text zu einer Referenz mittels N-Grammen, welche Wortfolgen der Länge N repräsentieren
  #cite(<Lin2004>, supplement: "S. 1-2").
Formal entspricht #acr("ROUGE")-n dem in @PrRecF1 definierten F1-Score, wobei anstatt absoluter Zuordnung die Übereinstimmung von N-Grammen als True Positive herangezogen werden #cite(<Hu2024LLMEvaluation>, supplement: "S. 14").

Sei $#vars("\u{03C9}")$ ein #varl("\u{03C9}"), $#vars("b") = (#vars("\u{03C9}")_1, #vars("\u{03C9}")_2,...,#vars("\u{03C9}")_(#vars("\u{039B}")_#vars("b")))$ ein #varl("b") der Länge $\u{039B}_#vars("b")$ als Wortsequenz von $#vars("\u{03C9}")_1$ bis $#vars("\u{03C9}")_(#vars("\u{039B}")_#vars("b"))$ und $#vars("d") = (#vars("\u{03C9}")_1, #vars("\u{03C9}")_2,...,#vars("\u{03C9}")_(#vars("\u{039B}")_#vars("d")))$ ein #varl("d") der Länge $\u{039B}_#vars("d")$ als Wortsequenz von $#vars("\u{03C9}")_1$ bis $#vars("\u{03C9}")_(#vars("\u{039B}")_#vars("d"))$. Damit ist $#vars("B")$ die #varl("B"), $#vars("D")$ die #varl("D") und $#vars("D") \u{2229} #vars("B")$ die Menge an überschneidenden n-Grammen, welche der Menge $#vars("TP")$ auf Basis von N-Grammen entsprechen. Die im generierten Text vorkommenden, aber nicht in der Referenz enthaltenen N-Gramme $#vars("B")\u{2216}#vars("D")$ entsprechen der Menge $#vars("FP")$, in der Referenz, aber nicht im generierten Text enthaltene N-Gramme $#vars("D")\u{2216}#vars("B")$ der Menge $#vars("FN")$ und weder in $#vars("B")$ noch in $#vars("D")$ vorkommende N-Gramme der Menge $#vars("TN")$. Auf Basis dieser N-Gramm basierten Mengen lassen sich $"Precision"_n$, $"Recall"_n$ sowie $#acrs("ROUGE")_n$ als N-Gramm basierter F1-Score mit den #box([folgenden Formeln berechnen:
  #cite(<Hu2024LLMEvaluation>, supplement: "S. 14"):])

$
  "Precision"_n = abs(#vars("D")\u{2229}#vars("B")) / abs(#vars("B"))
$

$
  "Recall"_n = abs(#vars("D")\u{2229}#vars("B")) / abs(#vars("D"))
$

$ 
  "ROUGE-n" = 2 dot ("Precision"_"n" dot "Recall"_"n") / ("Precision"_"n" + "Recall"_"n")
$

=== Large Language Model as a Judge
#acr("LLM") as a Judge bezeichnet einen Evaluationsansatz, bei dem #acrpl("LLM") zur Bewertung von Ergebnissen anderer Modelle eingesetzt werden
  #cite(<Li2024LLMJudge>, supplement: "S. 1-2"). 
Das Konzept basiert auf "Stacking"
  #cite(<wolpert1992stacked>, supplement: "S. 6-15"),
bei dem mehrere Modelle squentiell hintereinander geschaltet werden und sich gegenseitig bewerten und vervollständigen
  #cite(<Özbligin2025Stacking>, supplement: "S. 6"). 
#acr("LLM")-as-a-Judge nutzt diesen Ansatz, indem ein #acr("LLM") nach der Produktion eines #acr("LLM")-Outputs eingesetzt wird, um anhand definierter Kriterien diesen zu bewerten und quantitative Metriken zuzuweisen 
  #cite(<Li2024LLMJudge>, supplement: "S. 2-3").

#acr("LLM")-as-a-Judge weist Vorteile im Gegensatz zu traditionellen regelbasierten Bewertungsmethoden wie BLEU oder ROUGE auf, da #acrpl("LLM") deutlich besser in der Lage sind, angepasst an dynamischen Umständen und unstrukturierten Texten, diesen zu evaluieren
  #cite(<Liu2016HowNotToEvaluate>, supplement: "S. 2123-2126").
Darüber hinaus weisen durch #acr("LLM")-as-a-Judge getroffene Evaluationen hohe Korrelationen mit menschlicher Bewertung auf, wodurch hohe Kosten einer manuellen Evaluation in Teilen eingespart werden können
  #cite(<Krumdick2025NoFreeLabels>, supplement: "S. 1").
  #cite(<Li2024MATEval>, supplement: "S. 8-11").

Jedoch ist der Einsatz von #acr("LLM")-as-a-Judge durch seine Verwendung von #acrpl("LLM") mit Herausforderungen wie Halluzination und nicht-deterministische #acr("LLM")-Ausgaben verbunden
  #cite(<Li2024LLMJudge>, supplement: "S. 4-5"). 
Hinzu kommt, dass die Qualität der Bewertung stark von der Fähigkeit des #acrpl("LLM") abhängt, die bewerteten Aufgaben selbst zu lösen, wodurch die Wahl des #acr("LLM")-as-a-Judge-Modells stark abhängig von der zu bewertenden Aufgabe gewählt werden muss 
  #cite(<Krumdick2025NoFreeLabels>, supplement: "S. 1-3"). 

Für eine praktische und zuverlässige Anwendung von LLM-as-a-Judge ist es daher unabdingbar, eine Validierung mit von Menschen annotierten Referenzdaten durchzuführen, um ein geeignetes #acr("LLM") zu wählen und systematische Fehlerquellen der Evaluation zu reduzieren 
  #cite(<Krumdick2025NoFreeLabels>, supplement: "S. 1-3").

]