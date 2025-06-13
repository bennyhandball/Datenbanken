#import "acronyms.typ": acronyms 
#import "acronym-lib.typ": init-acronyms, print-acronyms, acr, acrpl, acrs, acrspl, acrl, acrlpl, acrf, acrfpl

#import "variables.typ": variables
#import "variables-lib.typ": init-variables, print-variables, var, varpl, vars, varspl, varl, varlpl, varf,varfpl

#import "rag_evaluation.typ": rag_evaluation
#import "indexing_similarity_search.typ": indexing_similarity_search

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
= Sperrvermerk
// Sperrvermerk Content
Die nachfolgende Arbeit enthält vertrauliche Daten und Informationen der SAP SE, Dietmar-Hopp-Allee 16, 69190 Walldorf, Deutschland. Der Inhalt dieser Arbeit darf weder als Ganzes noch in Auszügen Personen außerhalb des Prüfungsprozesses und des Evaluationsverfahrens zugänglich gemacht werden. Veröffentlichungen oder Vervielfältigungen der Projektarbeit #box("- auch auszugsweise -") sind ohne ausdrückliche Genehmigung der SAP SE in einem unbegrenzten Zeitrahmen nicht gestattet. Über den Inhalt dieser Arbeit ist Stillschweigen #box("zu wahren.")
#v(1.5em)
SAP und die SAP Logos sind eingetragene Warenzeichen der SAP SE. Die Wiedergabe von Gebrauchsnamen, Handelsnamen, Warenbezeichnungen usw. in dieser Arbeit berechtigt auch ohne besondere Kennzeichnung nicht zu der Annahme, dass solche Namen im Sinne der Warenzeichen- und Markenschutz-Gesetzgebung als frei zu betrachten wären und daher von jedem benutzt #box("werden dürfen.")

//-----------------------------------------------------------------------------------
// Gleichbehandlung
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
// Codeverzeichnis (List of Code) 
  #outline(
    title: "Codeverzeichnis",
    target: figure.where(kind: "code")
  )

#pagebreak()
// Abkürzungsverzeichnis (List of Abbreviations)
#print-acronyms(5em)

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
  footer: generate-footer-content("1"),
)
#pagebreak()
#counter(page).update(1)
#counter(heading).update(0)
#set heading(numbering: "1.",outlined: true)
#set math.equation(numbering: "(1)")

#set par(leading: 1.5em, spacing: 2.5em)

= Einleitung

#pagebreak()

= Methodik
== Cross Industry Standard Process for Data Mining <CRISP>
Um die Optimierung der Antwortqualität methodisch fundiert zu gestalten, bietet sich der #acrf("CRISP-DM") als bewährtes Modell an. Der #acr("CRISP-DM")-Prozess wurde 1996 von einem Konsortium,  bestehend aus Daimler Chrysler (damals Daimler Benz), SPSS (damals ISL) und National Cash Register (NCR) entwickelt, um ein standardisiertes, nicht proprietäres Prozessmodell zur Verfügung zu haben #cite(<ncr_clinton_2000>, supplement: "S.3").

Das #acr("CRISP-DM")-Modell ist ein branchenübergreifendes Standardmodell, das speziell für Data-Mining-Projekte entwickelt wurde #cite(<christoph_schröer_kruse_gómez_2021>, supplement: "S.527") #cite(<lendy_rahmadi_none_hadiyanto_ridwan_sanjaya_arif_prambayun_2023>, supplement: "S.401"). Es bietet eine strukturierte Vorgehensweise, um solche Projekte gezielt, effizient und systematisch umzusetzen #cite(<martinez-plumed_contreras-ochando_ferri_hernandez-orallo_kull_lachiche_ramirez-quintana_flach_2019>, supplement: "S.3048"). #acr("CRISP-DM") hat sich mittlerweile in der Data-Mining-Forschung etabliert und wird als de-facto-Standard anerkannt #cite(<christoph_schröer_kruse_gómez_2021>,supplement: "Abstract, S.526") #cite(<studer_bui_drescher_hanuschkin_winkler_peters_müller_2021>, supplement: "S.2")#cite(<martinez-plumed_contreras-ochando_ferri_hernandez-orallo_kull_lachiche_ramirez-quintana_flach_2019>, supplement: "S.3048").
//Supplement ergänzen
#figure(caption:
[Phasen des CRISP-DM Phasenmodells @wirth_hipp_2000 ]
, image(width:9.9cm,
"pictures/CRISP_DM_PA (1).png" 
))
<Phasen_CRISP_DM>

Der #acr("CRISP-DM") Data-Mining-Prozess kann in sechs iterative Phasen gegliedert werden (siehe @Phasen_CRISP_DM) #cite(<ncr_clinton_2000>, supplement: "S.13") #cite(<christoph_schröer_kruse_gómez_2021>, supplement: "S.527"). 

Diese Phasen sind: 


* 1. Business Understanding*:
Die erste Phase fokussiert sich auf die Formulierung der geschäftlichen Projektziele und Anforderungen #cite(<christoph_schröer_kruse_gómez_2021>, supplement: "S.527"). Diese werden anschließend in einen Data-Science Kontext überführt. Basierend auf  dieser Grundlage wird das Data-Mining-Problem definiert und ein vorläufiger Plan entwickelt, um die angestrebten Ziele zu erreichen #cite(<ncr_clinton_2000>,supplement: "S.13") #cite(<foroughi_luksch>, supplement: "S.8").

* 2. Data Understanding*:
Die Phase des Data Understandings beginnt mit der initialen Datenerhebung #cite(<foroughi_luksch>, supplement: "S.7"). Anschließend folgt die Datenanalyse, wobei mögliche Verknüpfungen, Zusammenhänge und erste Auffälligkeiten identifiziert werden #cite(<christoph_schröer_kruse_gómez_2021>, supplement: "S.527"). Im Folgenden wird die Qualität der Daten geprüft, um sicher zu stellen, dass die Daten für nachfolgende Analysen geeignet sind #cite(<foroughi_luksch>, supplement: "S.9").

* 3. Data Preparation*:
Die Phase der Data Preparation verfolgt das Ziel, die relevanten Daten gezielt auszuwählen, zu bereinigen, zu transformieren und zu integrieren, sodass ein finaler Datensatz für die Nutzung entsteht #cite(<ncr_clinton_2000>,supplement: "S.14") #box[#cite(<foroughi_luksch>, supplement: "S.9")]. Zudem werden neue Attribute oder Datensätze erstellt, während das Datenformat an die Anforderungen der Modellierungstools #box[angepasst wird #cite(<foroughi_luksch>, supplement: "S.8"). ]


* 4. Modelling*:
In dieser Phase werden geeignete Modellierungstechniken ausgewählt und anhand der vorbereiteten Daten angewendet #cite(<foroughi_luksch>, supplement: "S.9")#cite(<ncr_clinton_2000>,supplement: "S.14"). Die daraus folgenden Ergebnisse der Modelle werden bewertet und bei Bedarf optimiert. Die Auswahl eines Verfahrens zur Bewertung der Qualität des gewählten Modells ist hierbei von hoher Bedeutung. Das Ziel der Phase ist das bestmögliche Erreichen der zuvor definierten Ziele #cite(<wirth_hipp_2000>, supplement: "S.6") .





* 5. Evaluation*:
In dieser Phase erfolgt die umfassende Evaluation und Bewertung der zuvor erstellten Modelle #cite(<wirth_hipp_2000>, supplement: "S.6"). Zur Beurteilung der Modellqualität werden die zuvor festgelegten Testverfahren sowie die definierten Evaluationsmetriken herangezogen. Dabei wird überprüft, ob die entwickelten Modelle die gewünschten Ergebnisse liefern und die definierten Geschäftsziele vollständig erreichen #box[#cite(<ncr_clinton_2000>,supplement: "S.14") #cite(<wirth_hipp_2000>, supplement: "S.6").]


* 6. Deployment*: Die Erstellung des Modells stellt in der Regel nicht das Ende des Projekts dar #cite(<ncr_clinton_2000>,supplement: "S.14") #cite(<wirth_hipp_2000>, supplement: "S.7").
Je nach Anforderung und Zweck des Modells der geplanten Anwendung wird in diesem Schritt die Implementierung, der Projektabschluss und die Dokumentation des Modells durchgeführt #cite(<ncr_clinton_2000>,supplement: "S.14") #cite(<ncr_clinton_2000>,supplement: "S.32-34") #cite(<wirth_hipp_2000>, supplement: "S.7").
#pagebreak()

= Grundlagen
== Grundlagen Large Language Modellen 
#acrfpl("LLM") haben das #acrf("NLP") nachhaltig verändert, da diese natürliche Sprache verarbeiten und syntaktisch, semantisch und logisch korrekte Texte generieren können. #acrpl("LLM") werden auf großen Textdatensätzen trainiert und kombinieren neuronale Netze mit spezialisierten Architekturen wie dem Transformer der den Grundstein für ihre #box("Leistungsfähigkeit legt "+ cite(<PLMsPreTraining>,supplement: "S. 1-4")+cite(<AttentionIsAllYouNeed>, supplement:"S. 10")+".")

=== Grundlagen der Sprachverarbeitung und neuronaler Netze 
Das #acrf("NLP") befasst sich mit der maschinellen Verarbeitung und Erzeugung natürlicher Sprache, also der von Menschen intuitiv verwendeten gesprochenen und geschriebenen Sprache #cite(<PLMsPreTraining>,supplement: "S. 1"). Im Zentrum der maschinellen Sprachverarbeitung stehen neuronale Netze, die in ihrer Funktionsweise vom menschlichen Gehirn inspiriert sind #cite(<AttentionIsAllYouNeed>, supplement:"S. 1"). Diese Netze bestehen aus zahlreichen künstlichen Neuronen, die über Parameter, sogenannte Gewichte, miteinander verbunden sind.
#v(1em) 
#figure(caption:"Aufbau neuronaler Netze. In Anlehnung an "+cite(<krannig2020deep>)+". ",image(width: 80%,"pictures/neuronale_netze.jpeg"))<NeuronaleNetze>
#v(1em) 
Die Anpassung dieser Parameter ermöglicht es den Netzen, komplexe Muster und Zusammenhänge in den Eingabedaten zu erkennen und abzubilden #cite(<SCHMIDHUBER201585>, supplement: "S. 87"). Moderne #acrpl("LLM"), bei denen oftmals Milliarden Parameter zu dem Einsatz kommen, können somit feinste sprachliche #box("Nuancen  modellieren "+cite(<8666928>,supplement: "S. 68")+".")

=== Transformer-Architektur
Die Entwicklung heutiger leistungsfähiger #acrpl("LLM") ist eng mit der Einführung der Transformer-Architektur von Vaswani et al. in #cite(<AttentionIsAllYouNeed>, supplement: "Attention is All you Need") verknüpft. In der Transformer-Architektur wird der Eingabetext zunächst in kleinere Einheiten, sogenannte Tokens, zerlegt. Jedes dieser Tokens wird anschließend in einen hochdimensionalen Vektor umgewandelt, der dessen semantische Bedeutung repräsentiert. Der Self-Attention-Mechanismus des Transformers ermöglicht es, gleichzeitig die Beziehungen zwischen allen Tokens im Kontext zu analysieren und dynamisch ihre Relevanz zu gewichten. Diese Methode erlaubt es dem Modell, den Kontext eines jeden Wortes innerhalb eines Satzes präzise zu erfassen, was letztlich in der Fähigkeit resultiert, fließende und sinnvolle Texte #box("zu generieren. "+cite(<AttentionIsAllYouNeed>,supplement: "S. 3-5"))

Neben dem Self-Attention-Mechanismus sind Feedforward-Blöcke ein wesentlicher Bestandteil der Transformer-Architektur. Nachdem die relevanten Kontextinformationen ermittelt wurden, werden die resultierenden Vektoren in diese Blöcke eingespeist. Ein typischer Feedforward-Block besteht aus zwei linearen Schichten, die durch eine nichtlineare Aktivierungsfunktion getrennt sind. Zuerst wird der Eingabevektor in einen höherdimensionalen Raum transformiert, was eine detailliertere Repräsentation ermöglicht, und danach wieder auf die ursprüngliche Dimension reduziert. Diese Abfolge modelliert nichtlineare Zusammenhänge in den Daten und ermöglicht eine unabhängige Verarbeitung der Vektoren, was die Effizienz und Parallelisierbarkeit bei großen #box("Datenmengen ermöglicht. "+cite(<AttentionIsAllYouNeed>,supplement: "S. 5")+"")
#pagebreak()
=== Large-Scale Pre-Trained Language Models
Ein bedeutender Zweig der #acrpl("LLM") bilden #acrpl("PLM"), die durch ausgedehntes Vortraining auf umfangreichen Textkorpora ein tiefgehendes Sprachverständnis entwickeln und anschließend für spezifische Aufgaben feinjustiert werden können #cite(<PLMsPaper>, supplement: "S. 1"). #acrpl("PLM") werden oft synonym zum übergeordneten Begriff #acrpl("LLM") verwendet, da sie die Grundlage zahlreicher aktueller Modelle, wie Chat GPT und Claude, bilden. Zur Vereinfachung werden #acrpl("PLM") in dieser Arbeit unter dem Begriff #acr("LLM") zusammengefasst. Die Größe von #acrpl("LLM") bemisst sich an der Zahl der trainierbaren Parameter, die – neben Faktoren wie der Qualität der Trainingsdaten – ihr #box("Sprachverständnis beeinflussen "+cite(<brown2020languagemodelsfewshotlearners>, supplement: "S. 4")+".")

=== Trainingsprozess und Inferenz 
Der Aufbau und die Anwendung von LLMs basieren auf einem zweistufigen Trainingsprozess. In der Pre-Training-Phase wird das Modell auf umfangreichen Textdaten trainiert, um allgemeine Sprachstrukturen und -muster zu lernen. Nach dieser folgt die Fine-Tuning-Phase, in der das Modell auf spezifische Aufgaben oder Datensätze abgestimmt wird, um seine Leistung in spezifischen Anwendungsbereichen #box("zu optimieren "+cite(<LLMTaxonomyPrompting>, supplement: "S. 3-6")+".")

Nach Abschluss dieser Trainingsphasen kann man das #acr("LLM") nun in der Inferenz nutzen, bei der das Modell anhand eines #acr("Prompt") und auf Basis der gelernten Muster eine Ausgabe generiert #cite(<Inference>,supplement: "S. 3").  Der #acr("Prompt") ermöglicht es, das Verhalten des #acrpl("LLM") zu steuern und spezifische Kontextinformationen zu liefern. Dadurch wird im Rahmen der Inferenz, die Qualität und Relevanz der #box("Antworten maximiert "+cite(<LLMTaxonomyPrompting>, supplement: "S. 3-6")+".")
#pagebreak()

#import "embedding-modelle.typ": embedding-modelle
#embedding-modelle
== Vektordatenbanken
== Retrieval Augmented Generation (Tim)
#acrf("RAG") kombiniert die Stärken von #acrpl("LLM") mit dem gezielten Zugriff auf externe Wissensquellen. Klassische #acr("LLM")-Modelle fungieren dabei wie ein geschlossenes Buch. Sie schöpfen ausschließlich aus dem Trainingswissen und können aktuelle oder spezielle Informationen nicht einbeziehen #cite(<gupta2024comprehensivesurveyretrievalaugmentedgeneration>, supplement: "1"). Durch diese Einschränkung stoßen sie bei neuen oder spezialisierten Fragestellungen schnell an ihre Grenzen – und liefern mitunter falsche oder „halluzinierte“ Antworten, also frei #box("erfundene Inhalte "+cite(<gupta2024comprehensivesurveyretrievalaugmentedgeneration>, supplement: "2")+cite(<Huang_2025>, supplement: "S. 1, 3, 20")+cite(<ibm2023rag>)+".")

#figure(caption: "RAG Workflow entlang der Komponenten" + cite(<gupta2024comprehensivesurveyretrievalaugmentedgeneration>,supplement: "S. 2"),image(width: 80%,"pictures/RAG knowledge.png"))

#acr("RAG")-Systeme hingegen agieren wie ein Open-Book-Verfahren: Vor jeder Antwort durchsuchen diese eine hinterlegte Wissensbasis (Dokumente, Datenbanken o. Ä.) nach relevanten Textpassagen und übergeben diese als zusätzlichen Kontext an das #acr("LLM"). So lassen sich aktuelle Fakten und detaillierte Informationen direkt in die Antwort einbinden, ohne das #acr("LLM") neu trainieren zu müssen, was Präzision, gerade in spezialisierten Bereichen, und Nachvollziehbarkeit deutlich erhöht #cite(<gupta2024comprehensivesurveyretrievalaugmentedgeneration>, supplement: "1-2"). 


===  Wissensabruf und Anreicherung
Im #acr("RAG")-Verfahren erfolgt somit zu jeder Frage ein gezielter Abruf von Informationen aus der verbunden Wissensbasis. Die Inferenz wird dazu zunächst als Suchanfrage an das #acr("RAG")-System weitergeleitet. Jenes durchsucht dann die zuvor erstellte Wissensbasis (z.B. Dokumentensammlung, Datenbank oder Internetsuche) nach relevanten Textpassagen. Die so gefundenen Passagen werden dann als Kontext zusammen mit der Frage an das #acr("LLM") übergeben. Das #acr("LLM") kann dann die aus der Wissensbasis entnommenen Fakten direkt in seine Antwort einbeziehen #cite(<lewis2021retrievalaugmentedgenerationknowledgeintensivenlp>, supplement: "S. 9").
So können auch aktuelle Informationen, wie beispielsweise neueste Forschungsergebnisse oder Statistiken, in die Antwort einfließen, ohne dass das #acr("LLM") diese im Training lernen musste.
Die Antworten basieren damit auf verifizierten Quellen und bleiben stets aktuell, da neue Daten einfach in die Wissensbasis aufgenommen werden können. Dies erhöht sowohl die Qualität als auch die Aktualität der generierten Antworten, gerade in nischen Themen oder bei #box("neuen Erkenntnissen "+cite(<karpukhin2020densepassageretrievalopendomain>, supplement: "S. 8") +cite(<lewis2021retrievalaugmentedgenerationknowledgeintensivenlp>, supplement: "S. 9")).

=== Indexierung und Ähnlichkeitssuche

Ein zentraler Bestandteil eines #acr("RAG")-Systems ist die effiziente und präzise Indexierung der Wissensbasis sowie die darauf aufbauende Ähnlichkeitssuche. Die Qualität des Retrievals bestimmt maßgeblich, welche Informationen als Kontext in die Generierung einfließen und beeinflusst dadurch direkt die Qualität und Verlässlichkeit der Antworten #cite(<manning2008introduction>, supplement: "S. 9").

Zunächst müssen die zugrundeliegenden Dokumente oder Datensätze aufbereitet und segmentiert werden. Häufig werden Dokumente in passageartige Einheiten (z.B. Absätze oder Sätze) zerlegt, um eine granularere Suche zu ermöglichen. Dazu wird Tokenisierung und  Normalisierung eingesetzt, wenn klassische Information-Retrieval-Verfahren (sparse Retrieval) wie BM25 oder TF-IDF zum Einsatz kommen. Solche Verfahren zeigen in vielen Settings eine robuste Leistung, stoßen jedoch bei semantisch anspruchsvolleren Anfragen oder Paraphrasen an ihre Grenzen, da sie primär auf exakten #box("Wortüberlappungen beruhen "+cite(<karpukhin2020densepassageretrievalopendomain>, supplement: "S. 1")).

Um semantische Beziehungen besser abzubilden, wird in modernen RAG-Architekturen häufig ein dichtes Retrieval (dense Retrieval) eingesetzt. Hierbei werden Fragen und Dokument-Passagen in einen gemeinsamen Vektorraum abgebildet. Ein typischer Ansatz ist die Anwendung eines dualen Encoders (Fragen Encoder und Passagen Encoder), die jeweils auf Transformer-Modellen basieren und darauf trainiert werden, semantisch ähnliche Frage-Passage-Paare in der Nähe im Vektorraum zu verorten. Ein prominentes Beispiel ist der Dense Passage Retriever (DPR) von Karpukhin et al., der zeigt, dass ein solches dichtes Verfahren herkömmliche BM25-Systeme in Retrieval-Genauigkeit deutlich übertreffen kann. Die Trainingsdaten für solche Modelle können beispielsweise aus existierenden Frage-Antwort-Paaren stammen, die man aus QA-Datensätzen extrahiert #box("oder generiert "+cite(<karpukhin2020densepassageretrievalopendomain>, supplement: "S. 1")).

Nach der Erzeugung der Embeddings muss ein effizientes Indexierungssystem bereitgestellt werden. Bibliotheken wie FAISS erlauben es, große Mengen von Passage-Embeddings zu speichern und Suche in sublinearer Zeit zu realisieren. Dabei wird typischerweise eine Approximate Nearest Neighbor-Suche (ANN) verwendet, um trotz hoher Dimensionalität der Vektoren schnelle Antwortzeiten sicherzustellen #cite(<johnson2017billionscalesimilaritysearchgpus>, supplement: "S. 1, 2, 10"). Regelmäßige Aktualisierungen der Wissensbasis (etwa Hinzufügen neuer Dokumente) erfordern entweder inkrementelles Einpflegen neuer Embeddings oder periodisches erneuern des Index, um Aktualität zu gewährleisten. Gerade in Anwendungsfällen mit sich schnell änderndem Wissensbestand ist ein flexibler Update-Mechanismus essenziell.

Zusätzlich kann eine hybride Strategie verfolgt werden: Zuerst eine schnelle sparse Vorfilterung per BM25, danach Feinsortierung mit dichten Embeddings, um Kompromisse zwischen Effizienz und Präzision zu erreichen. Solche Kombinationen haben sich in der Praxis bewährt, insbesondere wenn die Wissensbasis sehr umfangreich ist und eine rein dichte Suche zu rechenintensiv wäre. Ebenso können Metadaten (z.B. Veröffentlichungsdatum, Dokumenttyp) als Filterbedingung einfließen, um irrelevante oder veraltete Passagen frühzeitig auszuschließen. 

=== Generative Antworterstellung

*Abwarten was wir nutzen*

Nachdem die relevanten Informationen abgerufen wurden, formuliert das LLM die Antwort. Das Modell erhält den ursprünglichen Fragestellungstext zusammen mit den gefundenen Dokumentauszügen als Eingabe.

learn.microsoft.com
Auf dieser Grundlage generiert das Sprachmodell den endgültigen Antworttext. Durch die Bereitstellung der externen Fakten kann das Modell die Antwort direkt auf den Quellen aufbauen, statt sich allein auf sein internes Wissen zu stützen.

promptingguide.ai

Dieser offene Ansatz sorgt dafür, dass die Antwort präziser und faktentreuer ist. Ein weiterer Vorteil ist, dass das System die Herkunft der Informationen kennt. Da die Antwort auf bestimmten Dokumenten basiert, kann man – sofern gewünscht – die verwendeten Quellen angeben.

research.ibm.com

Nutzer haben so die Möglichkeit, die Fakten selbst zu überprüfen, was das Vertrauen in die Ergebnisse erhöht. Außerdem entfällt das ständige Nachtrainieren des Modells, denn neue Informationen lassen sich einfach über die aktualisierte Wissensbasis bereitstellen.

en.wikipedia.org

Insgesamt ermöglichen RAG-Systeme so verlässlichere und aktuellere Antworten als klassische Sprachmodelle ohne externen Wissenseinbezug.

=== Retrieval Augmented Generation Parameter (Julian)

#rag_evaluation
#pagebreak()

= Unternehmensanwendung 

#pagebreak()

= Diskussion

== Einordnung der Ergebnisse

== Herausforderungen und Limitationen 

== Handlungsempfehlungen und zukünftige Forschung

#pagebreak()

= Schlussbetrachtung


== Fazit


== Ausblick

#pagebreak()





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
  footer: generate-footer-content("i"),
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
// Anhang Text
#heading("Anhang A", outlined: false)
#heading("Anhang B", outlined: false)
#heading("Anhang C", outlined: false)