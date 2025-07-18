#import "acronyms.typ": acronyms 
#import "acronym-lib.typ": init-acronyms, print-acronyms, acr, acrpl, acrs, acrspl, acrl, acrlpl, acrf, acrfpl

#import "variables.typ": variables
#import "variables-lib.typ": init-variables, print-variables, var, varpl, vars, varspl, varl, varlpl, varf,varfpl

#import "rag_evaluation.typ": rag_evaluation
#import "rag_parameter.typ": rag_parameter
#import "evaluation_and_deployment.typ": evaluation_and_deployment

// Set global cite style
#set cite(style: "ieee")

// Set global font type and size
#set text(font: "Arial", size: 12pt)

// Set line spacing to 1.5
#set par(leading: 1.5em)

// Define global text sizes
#let title-size = 1.5em
#let subtitle-size = 1.25em
#let body-size = 1em
#let section-spacing = 2em
#let spacing = 1em
#let small-spacing = 0.5em

// Define logo heights
#let left-logo-height = 1.5cm
#let right-logo-height = 1.5cm

// Define logo paths
#let logo-left = "pictures/DHBW_MA_Logo.jpg"
#let logo-right = "pictures/SAP_R_grad_scrn.jpg"
#let title = "Retrieval Augmented Generation"
#let nameAuthor = "Tim Christopher Eiser, Julian Konz & Benjamin Will"

// Define header and footer content
#let header-content = {}

#let generate-footer-content(numbering) = context {
  let heading_selector = heading.where(level: 1)
    // .or(heading.where(level: 2))
    // .or(heading.where(level: 3))
  
  // Query all headings matching the selector
  let all_headings = query(heading_selector)
  let current_page = here().page()
  
  let relevant_headings = ()
  for i in range(all_headings.len()) {
    let h = all_headings.at(i)
    let heading_page = h.location().page()
    let next_heading_page = if i + 1 < all_headings.len() { 
      all_headings.at(i + 1).location().page() 
    } else { 
      current_page + 1
    }
    
    if heading_page == current_page or (heading_page < current_page and next_heading_page > current_page) {
      relevant_headings.push(h)
    }
  }
  line(length: 100%)
  stack(
    dir: ltr,
    spacing: 1em,
    align(left, {
      if relevant_headings.len() > 0 {
        relevant_headings.map(h => h.body).join(" • ")
      } else {
        ""
      }
    }),
    align(right, text(size: 12pt, weight: "regular", counter(page).display(numbering)))
  )
}
#let header-content = {}

#let generate-footer-content-v-15(numbering) = context {
  let heading_selector = heading.where(level: 1)
    // .or(heading.where(level: 2))
    // .or(heading.where(level: 3))
  
  // Query all headings matching the selector
  let all_headings = query(heading_selector)
  let current_page = here().page()
  
  let relevant_headings = ()
  for i in range(all_headings.len()) {
    let h = all_headings.at(i)
    let heading_page = h.location().page()
    let next_heading_page = if i + 1 < all_headings.len() { 
      all_headings.at(i + 1).location().page() 
    } else { 
      current_page + 1
    }
    
    if heading_page == current_page or (heading_page < current_page and next_heading_page > current_page) {
      relevant_headings.push(h)
    }
  }
  line(length: 100%)
  v(-1.5em)
  stack(
    dir: ltr,
    spacing: 1em,
    align(left, {
      if relevant_headings.len() > 0 {
        relevant_headings.map(h => h.body).join(" • ")
      } else {
        ""
      }
    }),
    align(right, text(size: 12pt, weight: "regular", counter(page).display(numbering)))
  )
}
#let generate-footer-content3(numbering) = context {
  let heading_selector = heading.where(level: 1)
    // .or(heading.where(level: 2))
    // .or(heading.where(level: 3))
  
  // Query all headings matching the selector
  let all_headings = query(heading_selector)
  let current_page = here().page()
  
  let relevant_headings = ()
  for i in range(all_headings.len()) {
    let h = all_headings.at(i)
    let heading_page = h.location().page()
    let next_heading_page = if i + 1 < all_headings.len() { 
      all_headings.at(i + 1).location().page() 
    } else { 
      current_page + 1
    }
    
    if heading_page == current_page or (heading_page < current_page and next_heading_page > current_page) {
      relevant_headings.push(h)
    }
  }
  v(1.5cm)
  line(length: 100%)
  stack(
    dir: ltr,
    spacing: 1em,
    align(left, {
      if relevant_headings.len() > 0 {
        relevant_headings.map(h => h.body).join(" • ")
      } else {
        ""
      }
    }),
    align(right, text(size: 12pt, weight: "regular", counter(page).display(numbering)))
  )
}

//-----------------------------------------------------------------------------------
// Title Page
//-----------------------------------------------------------------------------------

// Place the logos
#stack(dir: ltr, spacing: 1fr,
  align(horizon, image(logo-right, height: right-logo-height)),
  align(horizon, image(logo-left, height: left-logo-height)),
)

// Title
#v(spacing*3)
#set par(leading: 0.5em)
#align(center, text(weight: "semibold", size: title-size, title))
#set par(leading: 1.5em)

#v(spacing)

// Confidentiality marker (SPERRVERMERK)
// #align(center, text(weight: "semibold", size: title-size, "SPERRVERMERK"))

#v(small-spacing)

// Type of Thesis
#align(center, text(weight: "semibold", size: subtitle-size, "Hausarbeit Datenbanken II"))

#v(small-spacing)

// Course of Studies
#align(center, text(size: body-size, "aus dem Studiengang Wirtschaftsinformatik Sales & Consulting"))

#v(small-spacing)

// University
#align(center, text(size: body-size, "an der Dualen Hochschule Baden-Württemberg Mannheim"))

#v(spacing)

// Author
#align(center, text(size: body-size, "von"))
#v(small-spacing)
#align(center, text(weight: "medium", size: subtitle-size, "Tim Christopher Eiser"+linebreak()+"Julian Konz"+linebreak()+"Benjamin Will"))


#v(spacing * 5)

// Author Information
#grid(
  columns: (auto, auto),
  row-gutter: 12pt,
  column-gutter: 2.5em,

  // Date
  text(weight: "semibold", size: body-size, "Bearbeitungszeitraum:"),
  text(size: body-size, "12.05.2025 - 03.08.2025"),

  // Student ID and Course
  text(weight: "semibold", size: body-size, "Kurs:"),
  text(size: body-size, "WWI23SCB"),

  // University Course Leader
  text(weight: "semibold", size: body-size, "Studiengangleiter:"),
  text(size: body-size, "Prof. Dr. -Ing. Clemens Martin"),

  // Spacer
  text(size: body-size, ""),
  text(size: body-size, ""),

  // Company
  text(weight: "semibold", size: body-size, "Ausbildungsfirma:"),
    stack(
    spacing: small-spacing,
    text(size: body-size, "SAP SE"),
    text(size: body-size, "Dietmar-Hopp-Allee 16"),
    text(size: body-size, "69190 Walldorf, Deutschland")
  ),


  // Spacer
  text(size: body-size, ""),
  text(size: body-size, ""),

  // University Supervisor
  text(weight: "semibold", size: body-size, "Dozent:"),
  stack(
    spacing: small-spacing,
    text(size: body-size, "Frank Neubüser"),
    text(size: body-size, "frank.neubueser@eviden.com"),
    text(size: body-size, "+49 (0) 211 399 36181")
  )
)

// Page break
#pagebreak()
//-----------------------------------------------------------------------------------
// Eidesstattliche Erklärung
//-----------------------------------------------------------------------------------
#set page(
  paper: "a4",
   margin: (
    left: 2cm,
    right: 2cm,
    top: 2.5cm,
    bottom: 2cm
  ),
  header: header-content,
  footer: generate-footer-content("I"),
  numbering: "I",
)
#counter(page).update(1)

#init-acronyms(acronyms)
#init-variables(variables)
#set heading(numbering: "I.",outlined: false)
#show heading.where(level: 1): it => {
  set text(size: 18pt, weight: "bold")
  v(1.5em)
  it
  v(1em)
}
#show heading.where(level: 2): it => {
  set text(size: 16pt, weight: "bold")
  v(1em)
  it
  v(0.5em)
}
#show heading.where(level: 3): it => {
  set text(size: 14pt, weight: "bold")
  v(1em)
  it
  v(0.5em)
}
#set par(justify: true, leading: 1.5em)
#set text(hyphenate: true, lang: "de")

= Eidesstattliche Erklärung
#align(left, text("Ich versichere hiermit, dass ich meine Projektarbeit mit dem Thema: „Titel“ selbstständig verfasst und keine anderen als die angegebenen Quellen und Hilfsmittel benutzt habe. Ich versichere zudem, dass die eingereichte elektronische Fassung mit der gedruckten "+box("Fassung übereinstimmt.")))

// Space for the signature
#v(7em)

// Table for "Ort, Datum" and "Unterschrift"
#grid(
  columns: (auto, auto),
  row-gutter: 1em,
  column-gutter: 12em, 
  // Left Column
  text(weight: "semibold", "__________________"),
  // Right Column
  text(weight: "semibold", "______________________________"),
  // Left Column
  text(weight: "semibold", "Ort, Datum"),
  // Right Column
  text(weight: "semibold", "Unterschrift Tim Christopher Eiser"),
  v(3em),v(1.5em),
  text(weight: "semibold", "__________________"),
  // Right Column
  text(weight: "semibold", "______________________________"),
  // Left Column
  text(weight: "semibold", "Ort, Datum"),
  // Right Column
  text(weight: "semibold", "Unterschrift Julian Konz"),
  v(3em),v(1.5em),
  text(weight: "semibold", "__________________"),
  // Right Column
  text(weight: "semibold", "______________________________"),
  // Left Column
  text(weight: "semibold", "Ort, Datum"),
  // Right Column
  text(weight: "semibold", "Unterschrift Benjamin Will")
)


//-----------------------------------------------------------------------------------
// Sperrvermerk
//-----------------------------------------------------------------------------------
#pagebreak()

= Gleichbehandlung der Geschlechter
In dieser Praxisarbeit wird aus Gründen der besseren Lesbarkeit das generische Maskulinum verwendet. Weibliche und anderweitige Geschlechteridentitäten werden dabei ausdrücklich mitgemeint, soweit es für die Aussage erforderlich ist.

//-----------------------------------------------------------------------------------
// Disclaimer
//-----------------------------------------------------------------------------------
#pagebreak()
= Disclaimer
// Disclaimer Content
Ein Teil der Literatur, die für die Anfertigung dieser Arbeit genutzt wird, ist nur über die E-Book-Plattform o'Reilly abrufbar. Bei diesen Ressourcen existieren keine Seitennummern, es wird bei Verweisen stattdessen die Kapitelnummer angegeben.
#v(1.5em)
Um den Lesefluss zu verbessern, werden Abbildungen, Codebeispiele und Tabellen, die den Lesefluss stören, im Anhang platziert, auf den im Text zusätzlich verwiesen wird.

//-----------------------------------------------------------------------------------
// Inhaltsverzeichnis, Abbildungsverzeichnis, Tabellenverzeichnis
//-----------------------------------------------------------------------------------

#set page(
  paper: "a4",
   margin: (
    left: 2cm,
    right: 2cm,
    top: 2.5cm,
    bottom: 4cm,
  ),
  header: header-content,
  footer: generate-footer-content3("I"),
  numbering: "I",
)
#pagebreak()
#show outline.entry.where(
  level: 1
): it => {
  v(12pt, weak: true)
  strong(it)
}


// Inhaltsverzeichnis (Table of Contents)
#outline(
    title: "Inhaltsverzeichnis",
    depth: 3,
    indent: 1em,
    )

#set page(
  paper: "a4",
   margin: (
    left: 2cm,
    right: 2cm,
    top: 2.5cm,
    bottom: 2cm
  ),
  header: header-content,
  footer: generate-footer-content("I"),
  numbering: "I",
)
#pagebreak()
// Abbildungsverzeichnis (List of Figures)
  #outline(
    title: "Abbildungsverzeichnis",
    target: figure.where(kind: image)
  )
#pagebreak()
// Tabellenverzeichnis (List of Tables)
  #outline(
    title: "Tabellenverzeichnis",
    target: figure.where(kind: table)
  )

#pagebreak()
// Promptverzeichniss (List of Code) 
  #outline(
    title: "Promptverzeichnis",
    target: figure.where(kind: "Prompt"
    )
  )

#pagebreak()
// Abkürzungsverzeichnis (List of Abbreviations)
#print-acronyms(5em)
#pagebreak()
// Variablenverzeichnis (List of Variables)
#print-variables(5em)


//-----------------------------------------------------------------------------------
// Inhalt der Arbeit
//-----------------------------------------------------------------------------------
#set heading(numbering: "1.")
#set page(
  paper: "a4",
  margin: (
    left: 2cm,
    right: 2cm,
    top: 2.5cm,
    bottom: 2cm
  ),
  header: header-content,
  numbering: "1",
  footer: generate-footer-content-v-15("1"),
)
#pagebreak()
#counter(page).update(1)
#counter(heading).update(0)
#set heading(numbering: "1.",outlined: true)
#set math.equation(numbering: "(1)")

#set par(leading: 1.15em, spacing: 2.15em)

= Einleitung
== Motivation
In den letzten Jahren hat die Forschung im Bereich der #acrpl("LLM") enorme Fortschritte gemacht. Spätestens mit der Veröffentlichung von Modellen wie GPT-4 ist klar: Generative #acr("AI")-Systeme haben das Potenzial, bestehende Prozesse in Wissenschaft, Wirtschaft und Gesellschaft grundlegend zu verändern. Doch bei aller Euphorie bleibt ein zentrales Problem ungelöst: #acrpl("LLM") basieren ausschließlich auf ihrem statischen Trainingswissen. Für Kontexte, in denen aktuelle oder domänenspezifische Informationen benötigt werden, versagen sie, halluzinieren, liefern veraltete oder schlicht falsche Antworten. Die Antwort der Forschung auf dieses #box("Problem lautet: "+acr("RAG")+".")

#acr("RAG")-Systeme verbinden klassische Sprachmodelle mit externem, dynamisch abrufbarem Wissen. Statt allein auf das interne Modellwissen zu vertrauen, ruft das System bei jeder Anfrage kontextrelevante Inhalte ab und reichert die Antwort dynamisch damit an. Studien wie Hasan et al. #cite(<hasan2025engineeringragsystemsrealworld>) zeigen, dass #acr("RAG") in Praxisfeldern wie Governance oder Medizin bereits erfolgreich eingesetzt werden kann. Für die wissenschaftliche Nutzung, wie die Analyse aktueller Paper, existieren jedoch kaum belastbare Daten zur #box("Leistungsfähigkeit von "+acr("RAG")+"-Systemen.")
#pagebreak()
== Forschungsfrage
Ausgehend von den beschriebenen Herausforderungen und Entwicklungen ergibt sich, für #box("uns, folgende "+acrf("RQ")+":")

*#acr("RQ")*: Wie leistungsfähig sind #acr("RAG")-Systeme bei der Beantwortung wissenschaftlicher Fachfragen auf Basis aktueller, zuvor nicht im #box("Modelltraining enthaltener Literatur?")

Diese Frage wird im Rahmen eines eigenen #acr("RAG")-Prototyps beantwortet, der für die Nutzung wissenschaftlicher Paper konzipiert wurde. Dabei liegt der Fokus nicht nur auf der technischen Optimierung, sondern auch auf der Bewertung der Antwortqualität #box("anhand etablierter Metriken.")

== Aufbau der Arbeit
#ref(<Methodik>) erläutert die methodische Herangehensweise auf Basis des #acr("CRISP-DM")-Prozesses. #ref(<Theorie>) liefert die theoretischen und technischen Grundlagen zu #acrpl("LLM"), Embedding-Modellen, Vektordatenbanken und dem #acr("RAG")-Konzept. In #ref(<Praxis>) wird das entwickelte System im Detail vorgestellt, einschließlich Datenbasis, Modellierung und Evaluationsstrategie. #ref(<Fazit>) schließt mit einer Zusammenfassung, diskutiert die Ergebnisse, Limitationen sowie den praktischen Nutzen und endet mit einen Ausblick auf weiterführende Forschung und sowie #box("Verwendung der Ergebnisse.")


#pagebreak()

= Methodik<Methodik>

Zur systematischen Analyse der Forschungsfrage wird das #acrf("CRISP-DM")-Prozessmodell verwendet #cite(<martinez-plumed_contreras-ochando_ferri_hernandez-orallo_kull_lachiche_ramirez-quintana_flach_2019>, supplement: "S.3048"). #acr("CRISP-DM") hat sich in der Praxis und Forschung im Bereich #acr("AI") und Data-Mining als de-facto-Standard etabliert #cite(<christoph_schröer_kruse_gómez_2021>,supplement: "S.526") #cite(<studer_bui_drescher_hanuschkin_winkler_peters_müller_2021>, supplement: "S.2")#cite(<martinez-plumed_contreras-ochando_ferri_hernandez-orallo_kull_lachiche_ramirez-quintana_flach_2019>, supplement: "S.3048"), und bietet eine klare Struktur zur Durchführung datengetriebener Projekte #cite(<christoph_schröer_kruse_gómez_2021>, supplement: "S.527") #cite(<lendy_rahmadi_none_hadiyanto_ridwan_sanjaya_arif_prambayun_2023>, supplement: "S.401"). #acr("CRISP-DM") ist domänenunabhängig einsetzbar, und ist insbesondere für komplexe Machine-Learning-Prozesse geeignet, bei welchen Datenauswahl, Modellierung und Evaluation eng verzahnt sind.

Im Kontext dieser Arbeit ermöglicht #acr("CRISP-DM") eine methodisch saubere Umsetzung des #acr("RAG")-Prototyps. Von der Zieldefinition über die zur Evaluation der Antwortqualität bis hin zur Entwicklung eines Prototyps. Die iterative Natur des Modells erlaubt es zudem, Erkenntnisse aus Zwischenschritten in spätere Phasen zurückzuführen und so das System iterativ #box("zu verbessern "+ref(<Phasen_CRISP_DM>)+".")

//Supplement ergänzen
#figure(caption:
[Phasen des CRISP-DM Phasenmodells @wirth_hipp_2000 ]
, image(width:65%,
"pictures/CRISP_DM_PA (1).png" 
))
<Phasen_CRISP_DM>

Der #acr("CRISP-DM") Data-Mining-Prozess kann in sechs iterative Phasen gegliedert werden (siehe @Phasen_CRISP_DM) #cite(<ncr_clinton_2000>, supplement: "S.13") #cite(<christoph_schröer_kruse_gómez_2021>, supplement: "S.527"). Diese Phasen sind: 


* 1. Business Understanding*:
Die erste Phase fokussiert sich auf die Formulierung der geschäftlichen Projektziele und Anforderungen #cite(<christoph_schröer_kruse_gómez_2021>, supplement: "S.527"). Diese werden anschließend in einen technischen Kontext überführt. Basierend auf  dieser Grundlage wird die Problemstellung definiert und ein Konzept entwickelt um diese #box("zu lösen "+cite(<ncr_clinton_2000>,supplement: "S.13") +cite(<foroughi_luksch>, supplement: "S.8")+".")

* 2. Data Understanding*:
Die Phase des Data Understandings beginnt mit der initialen Datenbeschreibung #cite(<foroughi_luksch>, supplement: "S.7"). Anschließend folgt die Datenanalyse, wobei Zusammenhänge und Auffälligkeiten untersucht werden #cite(<christoph_schröer_kruse_gómez_2021>, supplement: "S.527"). Zuletzt wird die Qualität der Daten geprüft, um sicherzustellen, dass die Daten für die folgende Modellierung #box("geeignet sind "+cite(<foroughi_luksch>, supplement: "S.9")+".")

* 3. Data Preparation*:
Die Phase der Data Preparation verfolgt das Ziel, die relevanten Daten auszuwählen, zu bereinigen und aufzubereiten, um einen Datensatz für die Modellierung zu erstellen #cite(<ncr_clinton_2000>,supplement: "S.14") #box[#cite(<foroughi_luksch>, supplement: "S.9")]. Zudem werden neue Attribute erstellt und das Datenformat an die Anforderungen der Modellierungstools #box[angepasst #cite(<foroughi_luksch>, supplement: "S.8"). ]


* 4. Modelling*:
In dieser Phase werden geeignete Modellierungstechniken ausgewählt und anhand der vorbereiteten Daten angewendet #cite(<foroughi_luksch>, supplement: "S.9")#cite(<ncr_clinton_2000>,supplement: "S.14"). Die daraus folgenden Ergebnisse der Modelle werden bewertet und bei Bedarf optimiert. Die Auswahl eines Verfahrens zur Bewertung der Qualität des gewählten Modells ist hierbei von hoher Bedeutung. Das Ziel der Phase ist das bestmögliche Erreichen der zuvor definierten Ziele #cite(<wirth_hipp_2000>, supplement: "S.6") .


* 5. Evaluation*:
In dieser Phase erfolgt die umfassende Evaluation und Bewertung der zuvor erstellten Modelle #cite(<wirth_hipp_2000>, supplement: "S.6"). Zur Beurteilung der Modellqualität werden die zuvor festgelegten Testverfahren sowie die definierten Evaluationsmetriken herangezogen. Dabei wird überprüft, ob die entwickelten Modelle die gewünschten Ergebnisse liefern und die definierten Geschäftsziele vollständig erreichen #box[#cite(<ncr_clinton_2000>,supplement: "S.14") #cite(<wirth_hipp_2000>, supplement: "S.6").]


* 6. Deployment*: Dieser Schritt umfasst die Implementierung des Modells, zum Beispiel als Prototyp, abhängig vom Modell Zweck und #box(" der geplanten Anwendung "+cite(<ncr_clinton_2000>,supplement: "S.14") +cite(<ncr_clinton_2000>,supplement: "S.32-34") +cite(<wirth_hipp_2000>, supplement: "S.7")+".")

Obwohl #acr("CRISP-DM") diesen etablierten Standard zur Strukturierung datengetriebener Projekte bietet, weist das Modell im Kontext moderner #acr("AI")-Anwendungen wie #acr("RAG") methodische Grenzen auf. Es wurde für klassische Data-Mining-Prozesse entwickelt und bildet neuere Konzepte wie Prompt-Engineering, semantisches Retrieval oder die nicht-deterministische Evaluation generativer Modelle nicht explizit ab #cite(<martinez-plumed_contreras-ochando_ferri_hernandez-orallo_kull_lachiche_ramirez-quintana_flach_2019>, supplement: "S.3049"). Ebenso fehlen integrierte Mechanismen zur Qualitätssicherung über alle Phasen hinweg, was insbesondere bei Systemen mit dynamischen Antwortverhalten wie #acrpl("LLM") #box("relevant ist.")

Trotz dieser Einschränkungen bietet #acr("CRISP-DM") eine geeignete methodische Grundlage für diese Arbeit. Das Modell erlaubt eine strukturierte, nachvollziehbare Durchführung des Entwicklungs- und Evaluationsprozesses. Die Phasen lassen sich flexibel auf die Anforderungen der #acr("RAG")-Systementwicklung übertragen #cite(<christoph_schröer_kruse_gómez_2021>, supplement: "S. 528"). Die iterative Struktur ermöglicht es zudem, Erkenntnisse aus der Evaluationsphase direkt in Modellierung und Datenaufbereitung zurückzuführen #cite(<martinez-plumed_contreras-ochando_ferri_hernandez-orallo_kull_lachiche_ramirez-quintana_flach_2019>, supplement: "S.3051"). Somit wird #acr("CRISP-DM") in dieser Arbeit nicht als starres Framework, sondern als anpassbarer Referenzrahmen genutzt, der gezielt um #acr("AI")-spezifische #box("Elemente ergänzt wird.")
#pagebreak()

= Grundlagen<Theorie>
#v(-0.5em)
== Grundlagen Large Language Modellen <LLM_Theorie>
#acrfpl("LLM") haben das #acrf("NLP") nachhaltig verändert, da diese natürliche Sprache verarbeiten und syntaktisch, semantisch und logisch korrekte Texte generieren können. #acrpl("LLM") werden auf großen Textdatensätzen trainiert und kombinieren neuronale Netze mit spezialisierten Architekturen wie dem Transformer, der den Grundstein für ihre #box("Leistungsfähigkeit legt "+cite(<PLMsPreTraining>, supplement: "S. 1-4")+cite(<AttentionIsAllYouNeed>, supplement:"S. 10")+".")
#v(-0.25em)
=== Architektur und Funktionsweise
Die Entwicklung heutiger leistungsfähiger #acrpl("LLM") basiert auf der Transformer-Architektur von Vaswani et al. #cite(<AttentionIsAllYouNeed>), die durch ihren Self-Attention-Mechanismus eine effiziente Verarbeitung natürlicher Sprache ermöglicht. Moderne #acrpl("LLM") werden durch ausgedehntes Vortraining auf umfangreichen Textkorpora entwickelt und können anschließend für spezifische Aufgaben angepasst werden #cite(<PLMsPaper>, supplement: "S. 1"). Die Größe von #acrpl("LLM") bemisst sich an der Zahl der trainierbaren Parameter, die – neben Faktoren wie der Qualität der Trainingsdaten – ihr #box("Sprachverständnis beeinflussen "+cite(<brown2020languagemodelsfewshotlearners>, supplement: "S. 4")+".")
#v(-0.25em)
=== Inferenz und Prompt-basierte Interaktion <Prompt_Kriterien>
Die praktische Anwendung von #acrpl("LLM") erfolgt in der Inferenz-Phase, in der das trainierte Modell anhand einer #acr("Prompt") und auf Basis der gelernten Sprachmuster eine Ausgabe generiert #cite(<Inference>,supplement: "S. 3"). Der #acr("Prompt") fungiert dabei als zentrale Schnittstelle zwischen Nutzer und Modell und ermöglicht es, das Verhalten des #acrpl("LLM") präzise zu steuern und spezifische Kontextinformationen zu übermitteln. Für die Formulierung von #acrpl("Prompt") haben sich folgende #box("Empfehlungen etabliert:")

- *Klarheit und Präzision*: Prompts sollten unmissverständlich und eindeutig formuliert sein, um ungenaue oder mehrdeutige Antworten #box("zu vermeiden.")
- *Bereitstellung von Kontext und relevanten Informationen*: #acrpl("LLM") erzielen bessere Ergebnisse, wenn sie die Zielgruppe sowie den spezifischen Anwendungsbereich und #box("Kontext kennen "+cite(<KNOTH2024100225>, supplement: "S. 5")+".")
- *Wahrung von Neutralität und Objektivität*: Um Verzerrungen zu vermeiden, sollten Prompts keine suggestiven oder wertenden Formulierungen enthalten, sodass die Antworten des Modells #box("objektiv bleiben "+cite(<chen2024usingpromptsguidelarge>, supplement: "S. 6-7")+".")
- *Nutzung spezifischer Formatvorgaben*: Durch die Definition eines strukturierten Ausgabeformats, etwa in Form von JSON-Schemata, wird die inhaltliche Konsistenz und Nachvollziehbarkeit der generierten Inhalte signifikant erhöht. Dieser Ansatz legt explizite Antwortparameter fest und erleichtert die nachgelagerte Verarbeitung, wodurch eine konsistente und zuverlässige Klassifikation #box("gewährleistet wird "+cite(<OpenAI2025StructuredOutputs>)+ cite(<hewing2024prompt>, supplement: "S. 11")+".")
Zudem lassen sich #acrpl("Prompt") in System- und User-#acrpl("Prompt") unterteilen. Ziel ist es durch diese Teilung die Leistung des Modells weiter positiv zu beeinflussen #cite(<marvin_hellen_jjingo_nakatumba_nabende_2024>, supplement: "S.388"). System- und User-#acrpl("Prompt") lassen sich #box("definieren wie folgt:")

- *System-Prompt:* 
  Der System-Prompt ist die initiale, funktionsspezifische Anweisung, die den Rahmen zwischen dem #acr("LLM") und dem menschlichen Benutzer definiert #cite(<mctear_ashurkina_2024>, supplement:"S.117"). Innerhalb des System-Promps, kann das Verhalten, die Formalität und Fachsprache definiert werden. Dazu werden der Kontext, die Rolle oder spezifische Regeln für die Interaktion festgelegt. #cite(<mrbullwinkle_2025>). 
- *User-Prompt:*
  Der User-Prompt ist die spezifische Eingabe des Endnutzers, auf die das Modell reagiert. Diese Anfrage stellt die Grundlage für die erzeugten Antworten dar #cite(<openai_platform_2025>). 

Während der Inferenz verarbeitet das #acr("LLM") die Eingabe tokenweise und generiert basierend auf den Wahrscheinlichkeitsverteilungen seiner Parameter eine kohärente Antwort. Die Qualität dieser Ausgabe hängt maßgeblich vom bereitgestellt #box("Kontext ab "+cite(<LLMTaxonomyPrompting>, supplement: "S. 3-6")+".")

#pagebreak()

#import "embedding-modelle.typ": embedding-modelle
#embedding-modelle
#pagebreak()
== Vektordatenbanken
Vektordatenbanken bilden eine spezialisierte Klasse von Datenbanksystemen, die darauf ausgelegt sind, hochdimensionale Vektorrepräsentationen effizient zu speichern, zu indexieren und durchsuchbar zu machen. Im Kontext von #acr("RAG")-Systemen fungieren sie als zentrale Infrastruktur für die Speicherung und den Abruf von Embedding-Vektoren, die semantische Informationen von #box("Textdokumenten repräsentieren. "+cite(<han2023comprehensivesurveyvectordatabase>, supplement: "S. 1-2"))
#v(-0.5em)
=== Architektur und Funktionsweise
Im Gegensatz zu relationalen Datenbanken speichern Vektordatenbanken Daten als numerische Vektoren in hochdimensionalen Räumen. Jeder Vektor repräsentiert semantische Eigenschaften eines Datenobjekts #cite(<han2023comprehensivesurveyvectordatabase>, supplement: "S. 1"), wobei die räumliche Nähe zwischen Vektoren die semantische Ähnlichkeit der ursprünglichen Inhalte widerspiegelt. Diese Eigenschaft ermöglicht komplexe Ähnlichkeitsabfragen ohne exakte #box("Schlüsselwort-Übereinstimmungen "+cite(<han2023comprehensivesurveyvectordatabase>, supplement: "S. 2")+".")
#v(-0.5em)
Die Architektur umfasst eine Speicherschicht für persistente Vektordaten, eine Indexierungsschicht für effiziente Organisation sowie eine Abfrageschicht für Ähnlichkeitssuchen. Zusätzlich unterstützen moderne Systeme die Speicherung von Metadaten für hybride Filterung und #box("Verfeinerung der Suchergebnisse. "+cite(<pan2023surveyvectordatabasemanagement>, supplement: "S. 1-4"))
#v(-0.5em)
=== Indexierung und Suchoptimierung
Für die effiziente Durchsuchung großer Vektorbestände setzen Vektordatenbanken spezialisierte Indexierungsalgorithmen ein. Hierarchical Navigable Small World (HNSW)-Graphen, eingeführt von Yu A Malkov et al. #cite(<Malkov>) ermöglichen durch mehrschichtige Navigationsstrukturen sublineare Suchzeiten bei hoher Genauigkeit. Alternative Verfahren wie Locality-Sensitive Hashing (LSH) bieten je nach Anwendungsfall spezifische Vorteile hinsichtlich Speichereffizienz #box("oder Suchgeschwindigkeit. "+cite(<han2023comprehensivesurveyvectordatabase>, supplement: "S. 4-7"))
#v(-0.5em)

Die Approximate Nearest Neighbor (ANN)-Suche bildet das methodische Fundament dieser Verfahren #cite(<Malkov>, supplement: "S. 1-3"). Da exakte Bestimmung der nächstgelegenen Nachbarn in hochdimensionalen Räumen rechnerisch aufwendig ist, approximieren diese Algorithmen die Ergebnisse mit kontrollierbarer Genauigkeit bei #box("reduzierten Rechenzeiten "+cite(<johnson2017billionscalesimilaritysearchgpus>, supplement: "S. 1, 2, 10")+cite(<Malkov>, supplement: "S. 1-5")+".")

=== Technische Implementierung
Moderne Vektordatenbanken bieten standardisierte APIs für sowohl Batch-Import großer Dokumentenmengen als auch Echtzeitabfragen. Die Systeme unterstützen verschiedene Distanzmetriken wie Kosinus-Ähnlichkeit, Euklidische Distanz oder Dot-Product zur Berechnung der Vektorähnlichkeit. Aktuelle Implementierungen bieten zusätzlich Funktionalitäten wie versionierte Vektorbestände, horizontale Skalierung und Multi-Tenancy-Fähigkeiten für #box("unternehmenskritische Anwendungen."+cite(<wang2025reliablevectordatabasemanagement>, supplement: "S. 2-4")+cite(<qdrant_indexing_2024>))

== Retrieval Augmented Generation<RAG>
#acrf("RAG") kombiniert die Stärken von #acrpl("LLM") mit dem gezielten Zugriff auf externe Wissensquellen. Klassische #acr("LLM")-Modelle schöpfen ausschließlich aus dem Trainingswissen und können aktuelle oder spezielle Informationen nicht einbeziehen #cite(<gupta2024comprehensivesurveyretrievalaugmentedgeneration>, supplement: "1"), was bei neuen oder spezialisierten Fragestellungen zu falschen oder „halluzinierten", also erfundenen, Antworten #box("führen kann "+cite(<gupta2024comprehensivesurveyretrievalaugmentedgeneration>, supplement: "1-2")+cite(<Huang_2025>, supplement: "S. 1, 3, 20")+cite(<ibm2023rag>)+".")

#acr("RAG")-Systeme hingegen durchsuchen vor jeder Antwort eine hinterlegte Wissensbasis (z.B. Dokumentensammlung, Datenbank oder Internetsuche) nach relevanten Textpassagen und übergeben diese als zusätzlichen Kontext an das #acr("LLM"). So lassen sich aktuelle Fakten und spezialisierte Informationen direkt einbinden, ohne das #acr("LLM") neu trainieren zu müssen, was Präzision und Nachvollziehbarkeit deutlich #box("erhöht "+cite(<gupta2024comprehensivesurveyretrievalaugmentedgeneration>, supplement: "1-2")+", ["+ref(<RAGWorkflow>)+"].")

===  Wissensabruf und Anreicherung
Im #acr("RAG")-Verfahren wird zu jeder Anfrage die Wissensbasis  nach relevanten Textpassagen durchsucht, die zusammen mit der Frage als zusätzlicher Kontext an das #acr("LLM") übergeben werden. Das #acr("LLM") kann dann die abgerufenen Fakten direkt in seine Antwort einbetten #cite(<lewis2021retrievalaugmentedgenerationknowledgeintensivenlp>, supplement: "S. 9"). So können auch aktuelle Informationen, wie neueste Forschungsergebnisse, einfließen, ohne dass das #acr("LLM") diese im Training lernen musste. Die Antworten basieren auf verifizierten Quellen und bleiben aktuell, da neue Daten einfach in die Wissensbasis aufgenommen werden können, was Qualität und Aktualität gerade bei nischen Themen #box("und neuen Erkenntnissen erhöht "+cite(<karpukhin2020densepassageretrievalopendomain>, supplement: "S. 8") +cite(<lewis2021retrievalaugmentedgenerationknowledgeintensivenlp>, supplement: "S. 9")).

=== Retrieval-Verfahren und Suchstrategien
Die Qualität des Retrievals bestimmt maßgeblich die Verlässlichkeit der #acr("RAG")-Antworten #cite(<manning2008introduction>, supplement: "S. 9"). Dokumente werden zunächst in passageartige Einheiten segmentiert und für die Suche aufbereitet. Bei klassischen Information-Retrieval-Verfahren (sparse Retrieval) kommen TF-IDF und BM25 zum Einsatz:
#v(-0.25em)
- *TF-IDF*: Gewichtet Terme durch Multiplikation der Termhäufigkeit mit dem inversen Dokumenthäufigkeitsmaß, sodass häufige Terme abgeschwächt und seltene Terme #box("hervorgehoben werden "+cite(<SPARCKJONES>, supplement: "S. 12, 13, 15")+cite(<BM25>,supplement: "S. 347-352")+".")
- *BM25*: Führt gesättigte Termfrequenz und Dokumentlängennormalisierung ein, um übermäßige Gewichtung und unverhältnismäßige Bevorzugung langer Dokumente #box("zu verhindern "+cite(<BM25>,supplement: "S. 352-369")+".")

Diese Verfahren zeigen robuste Leistung, stoßen jedoch bei semantisch anspruchsvollen Anfragen oder Paraphrasen an ihre Grenzen, da sie primär auf exakten #box("Wortüberlappungen beruhen "+cite(<karpukhin2020densepassageretrievalopendomain>, supplement: "S. 1")).

Modernes dichtes Retrieval (dense Retrieval) bildet Fragen und Dokument-Passagen in einen gemeinsamen Vektorraum ab. Duale Encoder (Fragen Encoder und Passagen Encoder) auf Transformer-Basis werden darauf trainiert, semantisch ähnliche Frage-Passage-Paare im Vektorraum zu verorten. Der #acr("DPR") von Karpukhin et al. #cite(<karpukhin2020densepassageretrievalopendomain>)) zeigt, dass solche Verfahren herkömmliche BM25-Systeme in der Retrieval-Genauigkeit deutlich #box("übertreffen können "+cite(<karpukhin2020densepassageretrievalopendomain>, supplement: "S. 1-3")).

Für die technische Umsetzung des dichten Retrievals werden die in Kapitel 2.2 beschriebenen Vektordatenbanken eingesetzt, die eine effiziente Speicherung und Durchsuchung der Embedding-Vektoren ermöglichen. Hybride Strategien kombinieren schnelle sparse Vorfilterung per BM25 mit dichter Feinsortierung über Vektordatenbanken, um Effizienz und Präzision zu balancieren. Metadaten können als Filterbedingung einfließen, um irrelevante oder veraltete Passagen #box("frühzeitig auszuschließen "+cite(<kuzi2020leveragingsemanticlexicalmatching>,supplement: "S. 1-4")).
#pagebreak()
=== Generative Antworterstellung

Im #acr("RAG")-System bildet die generative Antworterstellung den abschließenden Verarbeitungsschritt, in dem das vortrainierte Sprachmodell die ursprüngliche Nutzerfrage mit den durch das Retrieval-System identifizierten relevanten Dokumentfragmenten zu einem einzigen, kontextualisierten Prompt kombiniert und darauf basierend regressiv den finalen #box("Antworttext generiert."+cite(<lewis2021retrievalaugmentedgenerationknowledgeintensivenlp>, supplement: "S. 5-7"))

Für die Qualität der Antwort spielt die Wahl des #acr("LLM") eine entscheidende Rolle. Neue #acrpl("LLM") führender Anbieter können Zusammenhänge besser verstehen und detailliertere Antworten geben als bisherige Modelle. Ebenso wichtig ist die Größe des Kontextfensters – also wie viele Informationen das #acr("LLM") gleichzeitig verarbeiten kann. Ist dieses Fenster zu klein, gehen wichtige Quellenpassagen verloren. Ist es zu groß, wird das System langsamer und verbraucht mehr Ressourcen, ohne dass die Antworten proportional #box("besser werden "+cite(<roychowdhury2024erattaextremeragtable>, supplement: "S. 1-4")+".") 

Durch die unmittelbare Integration der abgerufenen Textpassagen in den Generierungsprozess minimiert der #acr("RAG")-Ansatz das Auftreten von Halluzinationen erheblich und gewährleistet, dass jede Antwort faktenbasiert und durch konkrete Quellen verifizierbar bleibt. Dieser Mechanismus eliminiert die Notwendigkeit aufwendiger Nachtrainingsverfahren des Sprachmodells, da neue oder aktualisierte Informationen direkt über die Wissensbasis eingebunden #box("werden können. "+cite(<kulkarni2024geneticapproachmitigatehallucination>, supplement: "S. 1"))

Die Transparenz des Verfahrens ermöglicht es darüber hinaus, die verwendeten Quelldokumente zu referenzieren, wodurch Nutzer die Möglichkeit erhalten, die faktische Grundlage der generierten Antworten selbst zu überprüfen und das Vertrauen in die Systemausgaben #box("zu stärken.")

#rag_parameter
#pagebreak()

#rag_evaluation
#pagebreak()

= Praktische Umsetzung<Praxis>
== Business Understanding
Besonders im akademischen Bereich stehen #acrpl("LLM") vor der Herausforderung, dass sie nur über die Informationen der Trainingsphase verfügen. Dies führt zu stark eingeschränkter Leistung, wenn hochspezialisiertes Wissen oder neue Erkenntnisse eingebunden werden sollen #cite(<karpukhin2020densepassageretrievalopendomain>, supplement: "S. 8") #cite(<lewis2021retrievalaugmentedgenerationknowledgeintensivenlp>, supplement: "S. 9"). Für dieses Problem bieten die in @RAG beschriebenen #acr("RAG")-Systeme eine mögliche Lösung. Ziel dieser Arbeit ist es, zu untersuchen, inwieweit #acr("RAG")-Systeme dazu geeignet sind, Studierenden und Wissenschaftlern schnellen Zugang zu aktueller Forschung zu ermöglichen und literaturbezogene Fragen zuverlässig #box("zu beantworten.")

Dazu wird ein eigenes #acr("RAG")-System entwickelt, das es erlaubt,  Literatur hochzuladen und gezielt Fragen dazu zu stellen. Die Qualität der Antworten wird evaluiert, um das Potenzial solcher Systeme für den akademischen Einsatz realistisch einschätzen #box("zu können.")

Für die Evaluation werden die in @EvaluationParameters genannten Metriken für die Quantifizierung der #box("Ergebnisse genutzt:")

- *N-Gramm-basierten Metriken*: Metriken wie Precision-n, Recall-n und #acr("ROUGE")-n vergleichen die generierten Antworten mit Referenzantworten, indem sie die Übereinstimmung von N-Grammen messen. Diese wird als Wert zwischen 0 und 1 wiedergegeben.
- *#acr("LLM")-as-a-Judge*: Diese Metrik nutzt ein #acr("LLM") als Bewertungsinstanz, um die Qualität der generierten Antworten zu beurteilen. Das #acr("LLM") bewertet die Antworten auf Basis der Kriterien "Total Correctness", "Completeness", "Relevance", "Justfiication" und "Depth", indem dieses eine numerische Punktzahl zwischen 0 und 2 je Kategorie vergibt.
#pagebreak()
== Data Understanding
Zur systematischen Evaluation des entwickelten #acr("RAG")-Systems wurde eine kuratierte Auswahl wissenschaftlicher Publikationen als Testdatensatz verwendet. Die Datengrundlage besteht aus fünf aktuellen Veröffentlichungen aus dem Bereich der Informatik, die von der wissenschaftlichen Publikationsplattform ArXiv.org bezogen wurden. Sämtliche ausgewählten Publikationen weisen ein einheitliches Veröffentlichungsdatum vom #box("27. Juni 2025 auf.")

Diese zeitliche Nähe zum Evaluationszeitpunkt (29. Juni 2025) stellt eine methodisch wichtige Kontrolle dar, da gewährleistet wird, dass die Inhalte dieser Publikationen mit hoher Wahrscheinlichkeit nicht Bestandteil der Trainingsdaten gängiger #acrpl("LLM") sind. Dadurch wird eine realistische und unvoreingenommene Evaluation der #acr("RAG")-Funktionalität ermöglicht, bei der das System tatsächlich auf die bereitgestellten Dokumente angewiesen ist, anstatt auf bereits internalisiertes Wissen zurückgreifen #box("zu können.")

Zur Validierung dieser Annahme wurde das eingesetzte #acr("LLM") explizit zu seiner Kenntnis der ausgewählten Publikationen befragt. Ohne Zugriff auf das #acr("RAG")-System bestätigte das Modell konsistent seine Unkenntnis bezüglich der spezifischen Inhalte aller fünf Publikationen, was die methodische Grundlage der #box("Evaluation stärkt.")

Die folgenden Publikationen wurden ausgewählt und decken verschiedene Bereiche der #box("Informatik ab:")

- "Engineering RAG Systems for Real-World Applications" #cite(<hasan2025engineeringragsystemsrealworld>) untersucht die praktische Implementierung von #acr("RAG")-Systemen in fünf verschiedenen Domänen (Governance, Cybersecurity, Agriculture, Industrial Research und Medical Diagnostics) und präsentiert zwölf Lessons Learned aus der Entwicklung #box("dieser Systeme.")
- "MAGPIE: A dataset for Multi-AGent contextual PrIvacy Evaluation" #cite(<juneja2025magpiedatasetmultiagentcontextual>) präsentiert einen Benchmark-Datensatz mit 158 realistischen Multi-Agenten-Szenarien zur Evaluation der kontextuellen Privatsphäre in #box(acr("LLM")+"-basierten Agentensystemen.")
- "Adaptive Hybrid Sort: Dynamic Strategy Selection for Optimal Sorting" #cite(<balasubramanian2025adaptivehybridsortdynamic>) stellt einen adaptiven Sortieralgorithmus vor, der basierend auf Dateneigenschaften wie Größe, Wertebereich und Entropie dynamisch zwischen Counting Sort, Radix Sort und #box("QuickSort wählt.")
- "Scalable GPU Performance Variability Analysis framework" #cite(<lahiry2025scalablegpuperformancevariability>) entwickelt ein verteiltes Framework zur Analyse von GPU-Performance-Logs, das große SQLite3-Tabellen in Shards partitioniert und parallel über #box("Message-Passing-Interface-Ranks verarbeitet.")
- "The Singapore Consensus on Global AI Safety Research Priorities" #cite(<bengio2025singaporeconsensusglobalai>) dokumentiert die Ergebnisse der 2025 Singapore Conference on AI mit über 100 Teilnehmern aus 11 Ländern. Das Konsens-Dokument strukturiert AI Safety Forschungsprioritäten in drei Hauptbereiche: Risk Assessment, Development und Control, und identifiziert Bereiche gegenseitigen Interesses für #box("internationale Kooperation.")

Diese Auswahl repräsentiert aktuelle Forschungsthemen aus verschiedenen Informatikbereichen und eignet sich damit gut zur Überprüfung der Generalisierbarkeit des #box("entwickelten "+acr("RAG")+"-Systems.")


== Data Preparation
Für jedes der fünf ausgewählten Paper werden fünf inhaltliche Fragen erstellt, die direkt auf das Verständnis und die Kernaussagen des jeweiligen Textes abzielen. Die Fragen und Antworten aus den Publikationen finden sich im Anhang in @Literaturfragen und wurden von Menschen mit der Hilfe von #acrpl("LLM") beantwortet. Die Fragen sind so konzipiert, dass sie ohne Zugriff auf das jeweilige Paper weder für Menschen noch für #acrpl("LLM") komplett zu beantworten sind, da sie spezifische technische Details, Evaluationsergebnisse oder methodische #box("Entscheidungen betreffen.")

Insgesamt liegt somit ein Datensatz von 35 Fragen (5 × 5 Inhlatsfragen, 5 × 2 Metadatenfragen) vor. Dieser dient im Weiteren als Basis für die Entwicklung des #acr("RAG")-Systems und Bewertung der #box("Antwortgenauigkeit in "+ref(<Evaluation>)+".")
#pagebreak()

== Modelling <Modelling>
Im Kontext von #acr("RAG") erfordert die Modelling Phase die systematische Auswahl und Konfiguration der Retrieval Komponente als auch der generativen Sprachmodelle um eine möglichst passende Harmonisierung zwischen dem Abruf relevanter Informationen und der kontextuellen Textgenerierung zu erreichen. Für die Entwicklung des Modells und die darauffolgende Analyse wurden folgende Technologien verwendet:

- *Programmiersprache Python:* Python eignet sich für #acr("AI")- und Data-Science-Anwendungen, da es eine klare Syntax, sowie eine breite Auswahl leistungsfähiger Bibliotheken bietet #cite(<nagpal_gabrani_2019>, supplement: "S.141-S.143"). Zusätzlich ermöglicht die Programmiersprache  eine schnelle Prototypentwicklung, modulare Strukturierung und eine gute Integrierbarkeit in bestehende Systeme #cite(<nagpal_gabrani_2019>, supplement: "S.141-S.143"). Python wurde für die Implementierung des #acr("RAG")-Systems und die Analyse der Optimierungsstrategien genutzt.

- *Qdrant Vektordatenbank:* Als Vektordatenbank wurde die QDrant-Vektordatenbank gewählt, da diese speziell für semantische Suche und Ähnlichkeitsabfragen optimiert ist #cite(<qdrant2025>). Zusätzlich unterstützt die Qdrant Vektordatenbank die Speicherung hochdimensionaler Vektoren und ermöglicht schnelle, skalierbare Top‑k‑Abfragen mittels Cosine Similarity oder anderer Distanzmetriken #cite(<qdrant2025>). Durch ihre Open-Source-Natur und einfache Integration lässt sich Qdrant auch ohne komplexe Infrastruktur in kleinere, experimentelle RAG-Systeme einbinden #cite(<qdrant2025>).



- *Embedding Modell text-embedding-3-large:* Das Modell text-embedding-3-large von OpenAI zeichnet sich durch eine Embedding-Dimension von 3072 Dimensionen aus #cite(<openai_text_embedding_3_large>). Des weiteren wird dieses Modell für präzise und höchste Genauigkeit in einem #acr("RAG")-System genutzt #cite(<openai_new_embedding_models_2024>). Damit verbunden ist allerdings auch ein hoher Rechenaufwand und Kostenaufwand, im Vergleich zu den anderen Embedding-Modellen, verbunden #cite(<openai_text_embedding_3_large>).  


Zur Generierung der Antworten mithilfe des #acr("RAG")-Systems werden, wie in @LLM_Theorie erläutert, #acrpl("LLM"), augrund ihrer hohen Performance gegenüber alternativen Verfahren eingestetzt. Vom Training eines eigenen Modells wird aufgrund von geringer Datengrundlage sowie Kosten- und Recheneleistung abgesehen und verschiedene #acrpl("PLM") eingesetzt #cite(<strubell_ganesh_mccallum_2019>, supplement: "S.3648,3649"). 

- *Generierendes Modell GPT-4o:* GPT-4o von OpenAI, veröffentlicht am 13. Mai 2024, zeichnet sich durch eine hohe Leistungsfähigkeit aus #cite(<gpt_4o>). Nach den Angaben von OpenAI ist das Modell GPT-4o das beste und leistungsfähigste Modell außerhalb der O-Serie #cite(<gpt_4o>). Im Vergleich zu diesen Modellen, wie beispielsweise o3-mini, ist GPT-4o schneller in der Sprachverarbeitung #cite(<gpt_4o>). 

- *Bewertendes Modell GPT-4o:* Als bewertendes Modell für den #acr("LLM")-as-a-Judge Ansatz wurde ebenfalls GPT-4o von OpenAI gewählt. Diese Modell bewertet, wie in @LLM-as-a-Judge, die zuvor generieten Antworten des #acr("RAG")-Systems. 

- *Prompting:* Die Erstellung des Prompts für das #acr("RAG")-System erfolgte nach den in der Literatur definierten Kriterien (siehe @Prompt_Kriterien). Das Prompt-Template (#ref(<ZeroShot>)), wurde dabei in allen Iterationen des #acr("RAG")-Systems konsistent eingesetzt. 


Das angehängte Prompt-Template (#ref(<LLMJUDGE>)) zeigt den Prompt für den #acr("LLM")-as-a-Judge Ansatz. Dieser wurde ebenfalls nach den in der Literatur definierten Kriterien (siehe #ref(<Prompt_Kriterien>)) erstellt und in allen Iterationen des #acr("RAG")-Systems konsistent eingesetzt.

Für die #acr("RAG")-Parameter gibt es keine expliziten Vorgaben für die Wahl der #acr("RAG") Parameter #cite(<chiang2024optimizing>). Diese sind Use-Case und Anforderungsspezifisch #cite(<chiang2024optimizing>). Für den vorliegenden Use-Case müsste man durch mehrere Experiment die beste Konfiguration der kombinierten Parameter ermitteln, da dies jedoch nicht der Fokus der Arbeit ist, soll im Folgenden die Wahl der Paramter begründet werden. 

- *Top-k-Retrieval Parameter:* Für die Implementierung des #acr("RAG")-Systems wurde der Top-k-Retrieval Parameter auf den Wert 5 gesetzt. Diese Entschidung basiert auf der in der Fachliteratur empfohlenen Praxis, verschiedene k-Werte systematisch zu evaluieren und einen ausgewogenen Mittelwert zu wählen #cite(<chiang2024optimizing>). Der Wert k=5 stellt dabei einen Kompromiss zwischen einem niedrigen k-Wert (k=1-2), die relevante Informationen übersehen könnten, und einem zu hohen k-Wert (k>=10), die zu einer Verschlechterung der Präzision durch irrelevante Treffer führen können dar #cite(<chiang2024optimizing>). 

- *Chunk Size/Overlap: *Für die Konfiguration der Chunk-Size des #acr("RAG")-Systems wird eine Chunk-Size von 1024 Tokens mit einem Overlap von 128 Token gewählt. Erfahrungen aus einem vergleichbaren Use-Case zeigenm dass diese naive Chunking-Methode passende Retrieval-Ergebnisse liefert #cite(<Ammar2025OptimizingRAG>). Gleichzeitig ermöglicht die gewählte Chunkgröße in Kombination mit einem Obverlap von 128 Token eine schnelle Verarbeitung bei hoher Genauigkeit. Daher stellt die Konfiguration mit 1024 Tokens und 128 Tokens Overlap eine passende Balance zwischen Qualität und Effizienz dar #cite(<Ammar2025OptimizingRAG>). 

- *Distanzmetrik:* Als weitverbreitete und zuverlässige Distanzmetrik wird die Cosinus Ähnlichkeit verwendet #cite(<juvekar2024cos>, supplement: "S.1"). Diese misst den Kosinus Winkel zwischen zwei Vektoren und ist somit geeignet, um semantische Ähnlichkeiten effektiv zu erfassen. 

#figure(caption:"Übersicht RAG Architektur. "+ box("Eigene Darstellung."),image(width: 98%,"pictures/RAG_Architektur.jpg"))<RAG_Architektur>


Die RAG-Architektur in (@RAG_Architektur) zeigt die projektspezifische Architektur des #acr("RAG")-Systems, die zur Beantwortung der in Abschnitt erläuterten Fragen eingesetzt wurde. Im Folgenden soll das Vorgehen näher erläutert werden.

Um die Fragen mit Hilfe des #acr("RAG")-Systems beantworten zu können, mussten zunächst die Kontextdaten zur Beantwortung der Fragen in die Vektor-Datenbank geladen werden. 
Die Daten für das Grounding beinhalten produktspezifische Daten von SAP über Joule, aus Dokumentationen, Guides und Blogs. Dazu wurden zunächst die Texte aus den Dokumenten extrahiert, in definierte Chunks aufgeteilt (Größe, Overlap) und anschließend mit Hilfe von drei Embedding-Modellen in unterschiedliche Datenbanken geladen. 

Die Fragen wurden zur Beantwortung aus einer -Datei ausgelesen, in Vektor-Embeddings umgewandelt und der Similarity Search zur Suche übergeben. Je nach aufgestellter Hypothese wurde entweder ein unterschiedliches Prompt-Template, ein Paramater wie Chunk-Größe oder der Retrieval-Paramter k für die Analyse verändert. Es wurde jeweils nur ein Parameter verändert, während die anderen Parameter konstant gehalten wurden, um eine direkte Korrelation zwischen dem veränderten Parameter und dem daraus resultierenden Ergebnis zu erhalten. 

Die durch die Similarity-Search ermittelten Chunks wurden dem Prompt als Text-Kontext mitgegeben, der im Anschluss durch das LLM GPT-4o bearbeitet wurde. Die Ergebnisse des LLM GPT-4o Modells wurden anschließend in eine -Datei geschrieben. 

Zur Beurteilung der Antwortqualität wurden die generierten -Dateien, sowie die manuell erstellte "Ground-Truth"-Antwort (Optimalantwort), mit Hilfe von Evaluationsmetriken (#acr("ROUGE"), Precision und Recall) analysiert. Anschließend wurde die generierte Antwort zusätzlich mit Hilfe des 
#acr("LLM")-as-a-Judge Modells Claude-3-Opus hinsichtlich Completeness und Correctness bewertet und mit dem Ergebnis der Evaluationsmetriken verglichen. 






#pagebreak()

#evaluation_and_deployment

#pagebreak()

= Schlussbetrachtung<Fazit>

== Zusammenfassung der Ergebnisse

In dieser Arbeit wurde ein prototypisches #acr("RAG")-System implementiert, das aktuelle wissenschaftliche Veröffentlichungen aus diversen Subdomänen der Informatik in Form von PDFs mithilfe eines tokenbasierten Chunkers in Segmente von 1024 Tokens Länge mit 128 Tokens Überlappung zerlegt, jedes Segment  anschließend durch das text-embedding-3-large-Modell von OpenAI in den Vektorraum überführt und in Qdrant als Vektordatenbank abgelegt. Bei einer Anfrage analysiert der Chatbot die Nutzerfrage, wandelt sie ebenfalls in einen Vektor um und ruft über k-Nearest-Neighbor-Retrieval die relevantesten Chunks ab. Diese Chunks werden via Prompt-Engineering zusammen mit der Originalfrage an OpenAI's GPT-4o übergeben, das die finale Antwort generiert und in natürlicher Sprache ausgibt.

Im Rahmen Gegenüber einer reinen LLM-Baseline verdoppelte sich die Precision-1 von 15,5% auf 32,6%, der Recall-1 stieg von 8,6% auf 32,4% und der #acr("ROUGE")-1-Score von 11,2% auf 29,1%; auch die 2-Gramm-Metriken verbesserten sich um 9–11 Prozentpunkte. Qualitative Bewertungen durch GPT-4o als „Richter“ ergaben im Durchschnitt 1,7/2 Punkten für Faktentreue, 2/2 für Relevanz und 1,2/2 für Vollständigkeit (Baseline: 0 Punkte). Die Ergebnisse belegen eindrücklich das Potenzial von #acr("RAG"), neue wissenschaftliche Publikationen zeitnah und präzise erschließbar zu machen. Auf Basis dieser Ergebnisse wurde ein Prototyp entwickelt, welcher das Hochladen sowie eine Abfrage von Informationen aus jenen Dokumenten in Form einer auf Flask basierenden Webapp erlaubt.
#pagebreak()
== Einordnung der Ergebnisse <Diskussion>
Die Ergebnisse aus @Evaluation reihen sich in die aktuelle Literatur zu #acr("RAG")-Systemen ein, die deren Potenzial zur Verbesserung der Antwortqualität von #acrpl("LLM") belegen. Die erreichte signifikante Verbesserung der Evaluationsmetriken ist vergleichbar mit den Ergebnissen von #cite(<lewis2021retrievalaugmentedgenerationknowledgeintensivenlp>, form: "prose", supplement: "S. 8") und #cite(<gupta2024comprehensivesurveyretrievalaugmentedgeneration>, form: "prose", supplement: "S. 10"), wobei die in dieser Arbeit erzielten Werte im Vergleich zu den in der Literatur berichteten Ergebnissen höher ausfallen. Dies könnte auf die spezifische Auswahl der Publikationen und die Leistungsfähigkeit neuerer #acr("LLM")-Modelle zurückzuführen sein, die in dieser Arbeit verwendet wurden.

Trotz allem unterliegen die Ergebnisse Limitationen hinsichtlich ihrer Aussagekräftigkeit, die in zukünftigen Arbeiten adressiert werden sollten. Folgende Herausforderungen und Limitationen wurden im Rahmen dieser Arbeit identifiziert:

- *#acr("CRISP-DM")*: Die Arbeit orientierte sich an der #acr("CRISP-DM")-Methode, die eine strukturierte Herangehensweise an Data Science-Projekte bietet. Dennoch könnte eine detailliertere Dokumentation der einzelnen Schritte und Entscheidungen im #acr("CRISP-DM")-Prozess die Nachvollziehbarkeit und Reproduzierbarkeit der Ergebnisse verbessern. #cite(<martinez-plumed_contreras-ochando_ferri_hernandez-orallo_kull_lachiche_ramirez-quintana_flach_2019>, supplement: "S. 1-3")
- *Begrenzte Datenbasis:* Die Evaluation basierte auf fünf Publikationen, aller dieser aus der Domäne der Informatik, was die Generalisierbarkeit der Ergebnisse einschränkt. Eine größere und diversifizierte Datengrundlage sowie eine Untersuchung der Evaluationsergebnisse bei Publikationen aus anderen Domänen könnte die Robustheit und Verallgemeinerbarkeit der Ergebnisse erhöhen. #cite(<salman2019overfittingmechanismavoidancedeep>, supplement: "S. 1-2")
- *Technische Limitationen:* Die Ergebnisse hängen stark von der Qualität und den Fähigkeiten der eingesetzten Technologien wie Embedding- und generierenden #acrpl("LLM") sowie der verwendeten Vektordatenbank von QDrant ab. Zukünftige Arbeiten sollten verschiedene #acr("LLM")-Modelle diverser Anbieter sowie mehrere Datenbanken vergleichen, um die bestmögliche Leistung zu erzielen und ein Vendor-Lock-In zu vermeiden. #cite(<choi2025advantages>, supplement: "S. 3-7")
- *Evaluationsmethoden:* Die verwendeten Metriken (Precision-n, Recall-n, #acr("ROUGE")-n, #acr("LLM")-as-a-Judge) sind standardisiert, aber möglicherweise nicht ausreichend, um die Qualität der Antworten vollständig zu erfassen #cite(<Hu2024LLMEvaluation>, supplement: "11-15"). Zukünftige Arbeiten sollten zusätzliche qualitative Bewertungsmethoden einbeziehen, um ein umfassenderes Bild der Antwortqualität zu erhalten sowie eine Validierung von Menschen vornehmen #cite(<Li2024LLMJudge>, supplement: "S. 1-3").

#pagebreak()

== Ausblick
Die Ergebnisse der Arbeit zeigen, dass #acr("RAG") ein vielversprechender Ansatz für die Verarbeitung aktueller wissenschaftlicher Literatur darstellt. Für die Verwendung im akademischen Umfeld eröffnet dies neue Potenziale, wie etwa zur Unterstützung bei Literaturrecherchen, dem automatisierten Beantworten fachspezifischer Fragen oder der schnellen Kontextualisierung #box("neuer Publikationen.")

Zukünfig sollte der Fokus auf die Optimierung der #acr("RAG")-Komponenten liegen. Insbesondere bei der Auswahl von Embedding-Modellen, der dynamischen Anpassung der Retrieval-Parameter sowie dem Einsatz spezialisierter LLMs für wissenschaftliche Domänen gibt es offene Optimierungspotenzialle. Darüber hinaus sind robustere Evaluationsstrategien notwendig, um subjektive Aspekte wie Relevanz oder Tiefe #box("objektiver zu messen.")

Langfristig bietet sich die Integration solcher Systeme in wissenschaftliche Software wie  akademische Suchmaschinen an. Ziel ist eine nahtlose, zuverlässige Ergänzung für #box("Forschung und Lehre.")





//-----------------------------------------------------------------------------------
// Literaturverzeichnis
//-----------------------------------------------------------------------------------
#set page(
  paper: "a4",
  margin: (
    left: 2cm,
    right: 2cm,
    top: 2.5cm,
    bottom: 2cm
  ),
  header: header-content,
  numbering: "i",
  footer: generate-footer-content-v-15("i"),
)
#set heading(numbering: none)
#pagebreak()
#counter(page).update(1)
#counter(heading).update(0)
#set heading(numbering: "i.")
= Literaturverzeichnis
#bibliography("sources.bib",title: none)


//-----------------------------------------------------------------------------------
// Anhang
//-----------------------------------------------------------------------------------
#pagebreak()
= Anhang 
#set heading(outlined: false)
== Abbildungen
#figure(caption: "RAG Workflow entlang der Komponenten " + cite(<gupta2024comprehensivesurveyretrievalaugmentedgeneration>,supplement: "S. 2"),image(width: 100%,"pictures/RAG knowledge.png"))<RAGWorkflow>
== Verwendete Prompts
#figure( table(
    columns: (12%,20%, 70%),
    row-gutter: 0.5em,
    column-gutter: -0.25em,
    align: (x, y) => if x == 0 or x == 1 {left + top} else if y == 0 {left + top } else {left + horizon},
    stroke: (x, y) => if y == 0 or y == 7{
    (bottom: 0.7pt + black)
  },
    table.header(
    [*Type*],[*Bestandteil*], [*Prompt Text*]
    ),
    [*System:*],[Kontext:], [
      #set par(leading: 0.5em, spacing: 1.5em)
      
      You are a precise and helpful AI assistant that answers questions IN GERMAN based strictly on the provided context. Your primary goal is to provide accurate, relevant, and well-sourced responses using only the information given in the context.
],
    

    [*User:*],[Aufgabe:],[
      #set par(leading: 0.5em, spacing: 1.5em)
      Analyze the given context documents and provide accurate, complete answers to user questions using only the information contained within those documents:],
    [],[Question:], [Question to answer: {question} ],
    [],[Context:], [Context documents: {context} ],


  ),
  caption:"Prompt-Template"
  ,kind: "Prompt",
  supplement: "Prompt"
)<ZeroShot>
#figure( table(
    columns: (12%,20%, 70%),
    row-gutter: 0.5em,
    column-gutter: -0.25em,
    align: (x, y) => if x == 0 or x == 1 {left + top} else if y == 0 {left + top } else {left + horizon},
    stroke: (x, y) => if y == 0 or y == 7{
    (bottom: 0.7pt + black)
  },
    table.header(
    [*Type*],[*Bestandteil*], [*Prompt Text*]
    ),
    [*System:*],[Kontext:], [
      #set par(leading: 0.5em, spacing: 1.5em)
  You are an expert evaluator. Your task is to judge the candidate answer (`answer_llm`) against the reference answer (`answer_gold`)
  for the given question (`question_string`).
 
  Use the following three-point scale for each criterion:
  0 = not fulfilled at all (the answer is incorrect, irrelevant, or missing)
  1 = partially fulfilled (the answer shows some correct elements but is incomplete or imprecise)
  2 = fully fulfilled (the answer is correct, complete and precise)
 
  Evaluate on these five criteria exactly:
  1. Factual correctness: Are the facts in the answer correct and accurate?
  2. Completeness: Does the answer cover all aspects of the question?
  3. Relevance: Is the answer relevant to the question asked?
  4. Justification: Is the answer well-justified with clear reasoning?
  5. Depth: Does the answer show a deep understanding of the topic?
  
  Then compute:
  - overall_score = sum of the five individual scores
  - max_score = 10
  - pass = true if overall_score ≥ 8, otherwise false
  
  Output your evaluation as a single JSON object with these fields:
  {
    "question_id": string,
    "factual_correctness": 0–2,
    "completeness":        0–2,
    "relevance":           0–2,
    "justification":       0–2,
    "depth":               0–2,
    "overall_score":       integer,
    "max_score":           10,
    "pass":                boolean,
  }
  ],
    [*User:*],[Aufgabe:],[
      #set par(leading: 0.5em, spacing: 1.5em)
      Evaluate the following question and answers:],
    [],[question_id:], [{question_id} ],
    [],[question_string:], [{question} ],
    [],[answer_llm:], [{answer_llm} ],
    [],[answer_gold:], [{answer_gold} ],
  ),
  caption:"Evaluation-Prompt"
  ,kind: "Prompt",
  supplement: "Prompt"
)<LLMJUDGE>
== Ergebnisse der Evaluation <evaluation_total_results>
=== Precision-n, Recal-n und ROUGE-n Ergebnisse
#figure(caption:
[Precision-n, Recall-n und ROUGE-n je Frage. Eigene Darstellung. ]
, image(
"pictures/heatmap.png" 
))
<heatmap_n_grams>
=== LLM-as-a-Judge Ergebnisse

#figure(caption:
[LLM-as-a-Judge Metriken je Frage. Eigene Darstellung. ]
, image(
"pictures/heatmap_judge.png" 
))
<heatmap_judge>

#pagebreak()
== Literaturfragen & Antworten<Literaturfragen>
=== Paper 1: Engineering RAG Systems for #box("Real-World Applications")

- Welche spezifischen Herausforderungen identifizierten die Autoren beim Einsatz von OCR in den Agriculture- und Healthcare-PDFs, und welche Lösungsansätze #box("wurden implementiert?")
  
  Die Autoren identifizierten noisy OCR-Output als Hauptherausforderung, der die FAISS-Qualität in Agriculture- und Healthcare-PDFs erheblich degradierte und die Retrieval-Genauigkeit limitierte. Als Lösungsansätze implementierten sie eine Kombination aus TesseractOCR und easyOCR als alternative OCR-Engines, ergänzt durch regex-basierte Cleanup-Verfahren zur systematischen Nachbearbeitung des extrahierten Texts. Zusätzlich integrierten sie PyMuPDF für die Extraktion sowohl text-basierter als auch bild-basierter Inhalte und führten systematische Datenbereinigungsverfahren ein, die die Entfernung von OCR-Rauschen und Duplikaten zur Verbesserung der Retrieval-Qualität ohne Modifikation der #box("Modelle ermöglichten.")

- Wie unterscheidet sich die Systemarchitektur zwischen dem Disarm RAG und den anderen vier implementierten Systemen, insbesondere hinsichtlich #box("der Datenschutzanforderungen?")

  Das Disarm RAG-System unterscheidet sich fundamental von den anderen vier Systemen durch seine sicherheitsorientierte Architektur und Datenschutzanforderungen. Es wird auf einem sicheren Server bei CSC (Finnish IT Center for Science) gehostet, um vollständige Datenprivatsphäre zu gewährleisten, und verwendet LLaMA 2-uncensored via Ollama für offenen Zugang zu Cybersecurity-Wissen. Der entscheidende Unterschied liegt darin, dass Disarm RAG bewusst auf Quellzitationen verzichtet, während alle anderen Systeme Quellenreferenzen zur Transparenz anzeigen - diese Ausnahme erfolgt aufgrund der Sensitivität von Cybersecurity-Inhalten, um sensitive Materialien zu schützen und gleichzeitig GDPR-Risiken #box("zu reduzieren.")
#pagebreak()
- Welche konkreten Metriken und Bewertungsdimensionen wurden in der Web-basierten Nutzerstudie mit 100 Teilnehmern verwendet, und was waren #box("die Haupterkenntnisse?")

  Die web-basierte Nutzerstudie mit 100 Teilnehmern verwendete sechs Bewertungsdimensionen auf einer Likert-Skala (1-5): Ease of Use, Relevance of Information, Transparency, System Responsiveness, Accuracy of Answers und Likelihood of Recommendation, ergänzt durch qualitative offene Feedback-Fragen. Die Haupterkenntnisse zeigten, dass Ease of Use und Accuracy of Answers konstant positive Bewertungen erhielten, während Transparency und Recommendation stärkere Variation zwischen den Systemen aufwiesen. Besonders bedeutsam war, dass 83% der Teilnehmer eine aufgabenabhängige Präferenz für KI-generierte Antworten zeigten, was darauf hinweist, dass Vertrauen in RAG-Systeme kontingent und nicht absolut ist, abhängig von Antwortrelevanz, Transparenz und Ausrichtung auf #box("die Nutzerintention.")

- Warum wählten die Autoren Poro-34B für das AgriHubi-System und welche Vorteile bot dieses Modell gegenüber GPT-4o für #box("finnischsprachige Inhalte?")

  Die Autoren wählten Poro-34B für das AgriHubi-System, weil allgemeine Modelle wie GPT-4o bei domänenspezifischen und finnischsprachigen Anfragen erhebliche Schwächen zeigten, während Poro-34B speziell für die finnische Sprache optimiert ist. Das finnisch-optimierte Modell lieferte kontextuell relevanteren Antworten für die Verarbeitung von 200+ finnischsprachigen landwirtschaftlichen PDFs und bot bessere Kompatibilität mit Embedding-Modellen wie text-embedding-ada-002. Diese Auswahl ermöglichte es, landwirtschaftliches Wissen durch eine Streamlit-Chat-Schnittstelle mit SQLite-Logging und Feedback-Mechanismus für kontinuierliche Verbesserung zugänglicher zu machen, was die Bedeutung domänenspezifischer Sprachmodelle für mehrsprachige #box("RAG-Anwendungen unterstreicht.")
#pagebreak()

- Welche zwölf Lessons Learned wurden dokumentiert und wie verteilen sich diese auf technische, operative und #box("ethische Kategorien?")

  Die zwölf dokumentierten Lessons Learned verteilen sich auf drei Kategorien: Technical Development (5 Lessons) umfasst die Notwendigkeit domänenspezifischer Modelle, OCR-Fehlerauswirkungen auf Pipelines, Chunking-Balance zwischen Geschwindigkeit und Genauigkeit, FAISS-Skalierungsgrenzen und manuelles Environment-Management ohne Containerization. Operational Factors (5 Lessons) beinhalten SQLite für User-Interaction-Tracking, fragile Scraping-Pipelines, Self-Hosted-Setup für Geschwindigkeit und Compliance, saubere Daten für bessere Retrieval-Qualität und nutzerfeedback-gesteuerte Systemoptimierung. Ethical Considerations (2 Lessons) betreffen Quelldatei-Referenzen für Vertrauensaufbau und Dataset-Bias-Auswirkungen auf Retrieval-Balance, wobei die technischen Aspekte den größten Anteil ausmachen und die Komplexität der praktischen RAG-Implementierung in realen #box("Anwendungen widerspiegeln.")




=== Paper 2: #box("MAGPIE Dataset")
- Wie ist ein Datenpunkt im MAGPIE-Benchmark formal definiert (als Tupel) und welche Rolle spielen die Penalties und Utilities im Kontext der #box("Multi-Agenten-Interaktion?")
  
  Ein Datenpunkt im MAGPIE-Benchmark ist formal als Tupel ⟨N, T, D, C, I, P, p, U⟩ definiert, wobei N eine endliche Menge von Agenten {a1, a2, ..., ak} darstellt, T eine offene Aufgabe wie Ressourcenzuteilung beschreibt, D ein Deliverable zur Aufgabenabschluss markiert, C Constraints aus öffentlichen und privaten Informationen ableitet, I öffentliche Informationen bezeichnet, P private/sensible Daten umfasst, p Penalties für Datenleckagen definiert und U Belohnungen für Teilaufgaben festlegt. Die Penalties und Utilities spielen eine zentrale Rolle in Multi-Agenten-Interaktionen, da sie realistische Trade-offs zwischen Aufgabenerfüllung und Datenschutz schaffen - Agenten müssen strategisch entscheiden, ob sie niedrig-penalisierte Informationen (pij = 1) teilen, um hoch-belohnte Ziele (uik = 5) zu erreichen, während sie sensible #box("Daten (pil = 4) schützen.")
#pagebreak()

- Welche spezifischen Leakage-Raten zeigten GPT-4o und Claude-3.7-Sonnet im Explicit Instruction Setting verglichen mit dem Implicit #box("Instruction Setting?")

  Im Explicit Instruction Setting, wo Agenten explizit über Penalties informiert wurden ("Leaking private information x incurs penalty y"), zeigte GPT-4o eine deutlich niedrigere Leakage-Rate von 5.7%, während Claude-3.7-Sonnet mit 21.6% deutlich schlechter abschnitt. Im Implicit Instruction Setting, das realistischere Bedingungen mit generischen Warnungen simuliert ("Some information is private; avoid sharing it"), verschlechterten sich beide Modelle dramatisch: GPT-4o erreichte eine Leakage-Rate von 54.3% und Claude-3.7-Sonnet sogar 66.2%. Diese Ergebnisse demonstrieren, dass selbst state-of-the-art Modelle wie GPT-4o und Claude-3.7-Sonnet zwar gute Instruktionsbefolgung zeigen, aber ein mangelndes Verständnis für kontextuelle Privatsphäre aufweisen, wenn explizite #box("Anweisungen fehlen.")

- Wie wurde der Datengenerierungsprozess mittels LLM-Pipeline durchgeführt und welche Verifikationsschritte #box("wurden implementiert?")

  Der Datengenerierungsprozess wurde durch eine mehrstufige LLM-Pipeline durchgeführt, die Claude-3.7-Sonnet sowohl als Generator als auch als Verifizierer nutzte. Der Prozess begann mit manuell kuratierten Seeds für verschiedene Domänen, gefolgt von automatischer Szenario-Generierung durch das LLM, das realistische High-Stakes-Szenarien vorschlug. Jede Stufe beinhaltete strenge Verifikationsschritte: Ein Verifizierer-LLM bewertete die Realitätsnähe und den Einsatz der Szenarien, überprüfte die Aufgaben-Agent-Ausrichtung, validierte die Kohärenz von Agentenprofilen und stellte sicher, dass private Informationen natürlich motiviert waren. Zusätzlich wurden durch einen finalen Verifikationsschritt Deliverables und Constraints gegen die Aufgabenziele geprüft, um konfliktfreie und lösbare #box("Aufgaben zu gewährleisten.")
#pagebreak()

- Was ist der Zusammenhang zwischen der Leakage-Rate und der Task-Success-Rate, wie in #box("Abbildung 7 dargestellt?")

  Abbildung 7 zeigt eine starke negative Korrelation zwischen der Leakage-Rate und sowohl der Konsens- als auch der Erfolgswahrscheinlichkeit. Aufgaben mit ≤10% Leakage erreichten nur 10.8% Konsens und 6.3% Erfolg, während die Raten bei etwa 67% Leakage plateauieren. Diese Beziehung verdeutlicht ein fundamentales Dilemma in Multi-Agenten-Systemen: Während strikte Datenschutzwahrung die Aufgabenerfüllung behindert, führt uneingeschränktes Informationsteilen zu höheren Erfolgsraten, aber auch zu Datenschutzverletzungen. Die Gesamtkonsens- und Erfolgsrate über alle Modelle betrug nur 51% bzw. 29.7%, was zeigt, dass aktuelle Modelle weder auf kontextuelle Datenschutzwahrung noch auf effektive Multi-Agenten-Kollaboration #box("ausgerichtet sind.")

- Welche fünf Hauptdomänen deckt der MAGPIE-Datensatz ab und welche Art von High-Stakes-Szenarien wurden für jede #box("Domäne entwickelt?")

  Der MAGPIE-Datensatz umfasst 158 Aufgaben über 16 verschiedene High-Impact-Domänen, wobei die Hauptkategorien Legal, Scheduling, Healthcare, Tech & Infrastructure und Research umfassen. Spezifische High-Stakes-Szenarien beinhalten strategische GPU-Ressourcenzuteilung zwischen Forschungsteams mit privaten Projektdetails und Latenzanforderungen, Universitätszulassungen mit vertraulichen Budgetbeschränkungen und Bewerberdaten, Gehaltsverhandlungen mit sensiblen Informationen über andere Mitarbeitergehälter, Büro-Miteigentümerschaftsvereinbarungen mit privaten finanziellen Präferenzen und Crowdsourced Innovation in der Pharmaentwicklung mit teilweise geheimen Forschungsdurchbrüchen. Diese Szenarien wurden bewusst so gestaltet, dass vollständiger Ausschluss privater Daten die Aufgabenerfüllung behindert, während uneingeschränktes Teilen zu erheblichen realen Verlusten #box("führen könnte.")
#pagebreak()

=== Paper 3: Adaptive #box("Hybrid Sort")

- Welche drei Hauptparameter (state vector v) verwendet das AHS-System zur Entscheidungsfindung und welche konkreten Schwellenwerte wurden durch Bayesian #box("Optimization ermittelt?")

  Das AHS-System verwendet einen dreidimensionalen Zustandsvektor v = (n, k, H) zur dynamischen Entscheidungsfindung. Dabei repräsentiert n die Eingabegröße (Kardinalität des Arrays), k den Wertebereich (max(arr) - min(arr) + 1), und H die Informationsentropie (−∑ᵢ₌₁ᵏ pᵢ log₂ pᵢ). Durch multi-objektive Bayesian Optimization wurden die optimalen Schwellenwerte ermittelt: nthreshold = 20 (gegenüber theoretischen 16), kthreshold = 1.024 (gegenüber theoretischen 1.000), und kmax = 10⁶ (gegenüber theoretischen 2²⁰). Die Kalibrierung erfolgte durch Minimierung einer gewichteten Summe aus normalisierter Ausführungszeit und Speicherverbrauch mit α = 0.7 als #box("Zeit-Speicher-Tradeoff-Parameter.")
- Wie wurde der XGBoost-Klassifikator trainiert und welche Accuracy erreichte er bei der Vorhersage der #box("optimalen Sortierstrategie?")

  Der XGBoost-Klassifikator wurde auf 10.000 synthetischen Datensätzen trainiert, die verschiedene Kombinationen von Eingabeparametern abdeckten: n ∈ [10³, 10⁹], k ∈ [10, 10⁶], und H ∈ [0, log₂ k]. Das Modell erreichte eine Vorhersagegenauigkeit von 92.4% bei der Auswahl der optimalen Sortierstrategie, ergänzt durch einen F1-Score von 0.89, was robuste Performance auch bei unausgewogenen Strategieverteilungen demonstriert. Die Entscheidungslatenz beträgt nur 0.2ms pro Entscheidung, während das durch 8-Bit-Quantisierung optimierte Modell lediglich 1MB Speicher benötigt, was es für ressourcenbeschränkte Edge-Computing-Umgebungen #box("geeignet macht.")

- Unter welchen spezifischen Bedingungen wählt das System Counting Sort, Radix Sort oder QuickSort, basierend auf den #box("Werten von k und H?")

  Das System implementiert eine hierarchische Entscheidungslogik basierend auf den Werten von k und H: Counting Sort wird gewählt, wenn k ≤ 1000 (kleine Schlüsselbereiche) für optimale lineare Zeitkomplexität; Radix Sort kommt zum Einsatz, wenn k > 10⁶ UND H < 0.7·log₂(k) (große Bereiche mit strukturierten, niedrig-entropischen Daten) für überlegene Speichercharakteristika; QuickSort dient als Fallback-Strategie für alle anderen allgemeinen Fälle und gewährleistet robuste O(n log n) Performance. Zusätzlich wird Insertion Sort automatisch für sehr kleine Datensätze (n ≤ 20) ausgewählt, um dessen exceptional Cache-Effizienz in diesem Bereich #box("zu nutzen.")

- Welche Performance-Verbesserungen (in Prozent) wurden im Vergleich zu statischen Sortieralgorithmen auf verschiedenen #box("Datensätzen erzielt?")

  Die experimentellen Ergebnisse zeigen signifikante Performance-Steigerungen: AHS erreichte 30-40% Reduktion der Ausführungszeit gegenüber konventionellen statischen Sortieralgorithmen across diverse Datensätze. Bei großskaligen Benchmarks mit n = 10⁹ Elementen benötigte AHS nur 210 Sekunden gegenüber 380 Sekunden für Timsort, was einer 45% Verbesserung entspricht. Für mittlere Datensätze (n = 10⁷) wurde ein 1.8× Speedup (2.1s vs 3.8s) erreicht, während die Speichernutzung konstant bei 8GB blieb gegenüber 12GB für Counting Sort, was die Eignung für moderne #box("Big-Data-Anwendungen demonstriert.")

- Wie wurde die Hardware-aware Optimierung implementiert, insbesondere die dynamische Anpassung von k_max basierend auf L3-Cache und #box("Thread Count?")

  Die Hardware-aware Optimierung implementiert eine dynamische Anpassung von kmax basierend auf Systemressourcen gemäß der Formel kmax = (L3 Cache)/(4 × Thread Count). Diese Implementierung gewährleistet Thread-Parallelismus bei gleichzeitig speichereffizienter Cache-Nutzung und resultierte in einer 12% Erhöhung der Cache-Auslastung verglichen mit statischen Ansätzen. Das System aktiviert konditionale Parallelisierung nur wenn vorteilhaft: Radix Sort zeigt besonders effektive Skalierung mit 1.79× Speedup für Datensätze > 10⁶ Elemente trotz 12% Thread-Management-Overhead, während Quicksort aufgrund signifikanter Synchronisationskosten (47% Overhead) limitierte #box("Parallelisierbarkeit (1.12× Speedup) aufweist.")
#pagebreak()

=== Paper 4: Scalable GPU Performance #box("Variability Analysis")

- Welche spezifischen CUPTI-Tabellen wurden analysiert und wie viele Entitäten enthielt jede Tabelle nach #box("dem Left-Join?")

  Laut Tabelle 1 wurden drei spezifische CUPTI-Tabellen analysiert: KERNEL (CUPTI_ACTIVITY_KIND_KERNEL) mit 842.054 Entitäten für alle Ranks, MEMCPY (CUPTI_ACTIVITY_KIND_MEMCPY) mit variierenden Entitäten pro Rank (107.045 für Rank 0, 107.099 für Rank 1, 1.070.545 für Rank 2, und 107.045 für Rank 3), sowie GPU (TARGET_INFO_GPU) mit 4 Entitäten für alle Ranks. Nach dem Left-Join-Prozess ergaben sich approximativ 93 Millionen Entitäten, die zur weiteren Analyse #box("verwendet wurden.")

- Warum entschieden sich die Autoren für Block Partitioning statt Cyclic Partitioning bei der Verteilung der Shards #box("auf Message-Passing-Interface-Ranks?")

  Die Autoren entschieden sich für Block Partitioning über Cyclic Partitioning, da der Datensatz statisch ist und eine hohe Workload-Vorhersagbarkeit aufweist. Block Partitioning weist zusammenhängende Shards jedem Rank zu, was den Query-Overhead reduziert, die Datenlokalität verbessert und eine effiziente SQL-Query-Ausführung ermöglicht. Diese Methode ist besonders vorteilhaft für statische Datensätze, da sie die Kommunikationskosten zwischen den Ranks minimiert und die #box("Cache-Effizienz maximiert.")

- Welche Methode wurde zur Identifikation der Top-5 anomalous shards verwendet und wie #box("funktioniert diese?")
  
  Zur Identifikation der Top-5 anomalous Shards verwendeten die Autoren die Inter-Quartile Range (IQR) Methode. Diese statistische Methode berechnet zunächst gemeinsame Statistiken (Minimum, Maximum, Standardabweichung) kollaborativ über alle P Ranks in einem Round-Robin-Verfahren. Anschließend werden diese gemeinsamen Statistiken verwendet, um Anomalien zu identifizieren, wobei die IQR-Methode Ausreißer basierend auf der Verteilung der Daten innerhalb der Quartile bestimmt und die fünf auffälligsten Shards zur detaillierten #box("Analyse auswählt.")
#pagebreak()

- Was zeigt die Analyse der Memory Stall Duration für Rank 2 bezüglich der Device-to-Host und #box("Host-to-Device Transfers?")

  Die Analyse der Memory Stall Duration für Rank 2 ergab, dass Device-to-Host und Host-to-Device Transfers dominieren, was auf häufige Ping-Pong-Muster hindeutet, die durch ineffiziente Batch-Verarbeitung verursacht werden. Im Gegensatz dazu zeigen spärliche Device-to-Device Transfers seltene Intra-GPU-Operationen an, was Optimierungsmöglichkeiten durch Shared Memory Reuse oder Tiling-Strategien aufzeigt. Diese Erkenntnisse deuten darauf hin, dass die Datenübertragungseffizienz zwischen Host und Device ein kritischer Engpass für die #box("Performance darstellt.")

- Wie skaliert die Performance des Frameworks mit zunehmender Anzahl von Message-Passing-Interface-Ranks für Data Generation und #box("Data Aggregation?")

  Das Framework zeigt eine positive Skalierung mit zunehmender Anzahl von MPI-Ranks, wobei sowohl die Data Generation als auch die Data Aggregation Phase eine Verringerung der Ausführungszeit bei steigender Rank-Anzahl aufweisen. Figure 1(c) demonstriert, dass sich die Zeiten für beide Phasen mit mehr MPI-Ranks reduzieren, was beweist, dass die Pipeline skalierbar ist und große Datenmengen effizient verarbeiten kann. Diese Skalierbarkeit wird durch die verteilte Architektur ermöglicht, die die Arbeitslast gleichmäßig auf alle verfügbaren Ranks verteilt und #box("Bottlenecks vermeidet.")

=== Paper 5: The Singapore Consensus on Global AI Safety #box("Research Priorities")

- Wie wird das Defence-in-Depth-Modell konkret strukturiert und welche spezifischen Überschneidungen bestehen zwischen den drei Hauptbereichen Risk Assessment, Development #box("und Control?")

  Das Defence-in-Depth-Modell strukturiert die AI Safety Forschung in drei Hauptbereiche: Risk Assessment (Bewertung der Schwere und Wahrscheinlichkeit potenzieller Schäden), Development (Entwicklung vertrauenswürdiger, zuverlässiger und sicherer Systeme) und Control (Überwachung und Intervention nach der Bereitstellung). Die spezifischen Überschneidungen werden in Figure 1 als Venn-Diagramm illustriert: Zwischen Assessment und Development liegt "Specification, validation, assurance", zwischen Assessment und Control "Real-time monitoring", zwischen Development und Control "E.g. jailbreak refusal", und im Zentrum aller drei Bereiche befinden sich grundlegende Sicherheitstechniken. Diese Überschneidungen entstehen durch unterschiedliche Definitionen dessen, was als Teil des Systems versus als kontrollierende Feedback-Schleifen #box("betrachtet wird.")

- Welche acht Personen bildeten das Expert Planning Committee und aus welchen Institutionen stammten sie, und wie gestaltete sich der mehrstufige Feedback-Prozess #box("zur Konsensbildung?")

  Das Expert Planning Committee bestand aus acht Personen: Dawn Song (UC Berkeley), Lan Xue (Tsinghua University), Luke Ong (Nanyang Technological University), Max Tegmark (MIT), Stuart Russell (UC Berkeley), Tegan Maharaj (MILA), Ya-Qin Zhang (Tsinghua University) und Yoshua Bengio (MILA). Der mehrstufige Feedback-Prozess gestaltete sich folgendermaßen: Zunächst erstellte das Committee einen Konsultationsentwurf, der an alle Konferenzteilnehmer verteilt wurde, um umfassendes Feedback einzuholen. Nach mehreren Runden von schriftlichen und persönlichen Rückmeldungen der Teilnehmer wurde das Dokument überarbeitet, um Punkte des breiten Konsenses unter den diversen Forschern #box("zu synthetisieren.")

- Was sind "Areas of mutual interest" im Kontext der AI Safety Forschung und welche konkreten Beispiele werden für potentiell kooperative #box("Forschungsbereiche genannt?")

  "Areas of mutual interest" bezeichnen Forschungsbereiche, bei denen verschiedene Akteure (Unternehmen, Länder) trotz Konkurrenz gemeinsame Interessen haben und Anreize bestehen, Informationen und Forschungsergebnisse zu teilen. Das Paper gibt konkrete Beispiele: bestimmte Verifikationsmechanismen, Risikomanagement-Standards und Risikobewertungen, da diese minimalen Wettbewerbsvorteil bieten, aber einem gemeinsamen Interesse dienen. Ähnlich wie konkurrierende Flugzeughersteller (Boeing und Airbus) bei Flugsicherheitsinformationen und -standards kooperieren, könnten AI-Akteure bei der Zusammenarbeit profitieren, da niemand von AI-Zwischenfällen oder der Ermächtigung böswilliger #box("Akteure profitiert.")
#pagebreak()

- Welche spezifischen Definitionen werden für die Begriffe "Artificial General Intelligence (AGI)" und "Artificial Superintelligence (ASI)" im #box("Glossar gegeben?")

  Das Glossar definiert "Artificial General Intelligence (AGI)" als "AI that can do most cognitive work as well as humans. This implies that it is highly autonomous and can do most economically valuable remote work as well as humans." "Artificial Superintelligence (ASI)" wird definiert als "AI that can accomplish any cognitive work far beyond human level." Zusätzlich wird AGI in Figure 2 als Schnittmenge von drei Eigenschaften dargestellt: Autonomy (A), Generality (G) und Intelligence (I), wobei Systeme mit allen drei Eigenschaften am schwierigsten zu #box("kontrollieren sind.")

- Wie wird Ashby's Law of Requisite Variety im Kontext der AI-Kontrolle erklärt und welche Implikationen ergeben sich daraus für #box("Human-centric Oversight?")
  
  Ashby's Law of Requisite Variety besagt, dass für Sicherheitsgarantien ein Kontrollsystem generell mindestens so viel Komplexität haben muss wie das System, das es zu kontrollieren versucht. Im Kontext von Human-centric Oversight bedeutet dies, dass es natürliche Grenzen für die Kontrollierbarkeit von Systemen gibt, basierend auf Denkgeschwindigkeit, Proaktivität, Expertisegrad, Aufmerksamkeit für Details und Zuverlässigkeit menschlicher Operatoren. Selbst mit AI-Assistenz, die Menschen beim Verstehen des gegebenen Kontexts unterstützen, deutet das Gesetz darauf hin, dass das kontrollierende System mindestens so viel Ausdrucksfähigkeit haben muss wie das kontrollierte System. Dies stellt eine fundamentale Herausforderung für die Überwachung hochentwickelter #box("AI-Systeme dar.")

