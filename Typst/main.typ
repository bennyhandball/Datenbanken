#import "acronyms.typ": acronyms 
#import "acronym-lib.typ": init-acronyms, print-acronyms, acr, acrpl, acrs, acrspl, acrl, acrlpl, acrf, acrfpl

#import "variables.typ": variables
#import "variables-lib.typ": init-variables, print-variables, var, varpl, vars, varspl, varl, varlpl, varf,varfpl

#import "rag_evaluation.typ": rag_evaluation
#import "rag_parameter.typ": rag_parameter

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
  footer: generate-footer-content-v-15("1"),
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
#v(-0.5em)
== Grundlagen Large Language Modellen
#acrfpl("LLM") haben das #acrf("NLP") nachhaltig verändert, da diese natürliche Sprache verarbeiten und syntaktisch, semantisch und logisch korrekte Texte generieren können. #acrpl("LLM") werden auf großen Textdatensätzen trainiert und kombinieren neuronale Netze mit spezialisierten Architekturen wie dem Transformer, der den Grundstein für ihre #box("Leistungsfähigkeit legt "+cite(<PLMsPreTraining>, supplement: "S. 1-4")+cite(<AttentionIsAllYouNeed>, supplement:"S. 10")+".")
#v(-0.25em)
=== Architektur und Funktionsweise
Die Entwicklung heutiger leistungsfähiger #acrpl("LLM") basiert auf der Transformer-Architektur von Vaswani et al. #cite(<AttentionIsAllYouNeed>), die durch ihren Self-Attention-Mechanismus eine effiziente Verarbeitung natürlicher Sprache ermöglicht. Moderne #acrpl("LLM") werden durch ausgedehntes Vortraining auf umfangreichen Textkorpora entwickelt und können anschließend für spezifische Aufgaben angepasst werden #cite(<PLMsPaper>, supplement: "S. 1"). Die Größe von #acrpl("LLM") bemisst sich an der Zahl der trainierbaren Parameter, die – neben Faktoren wie der Qualität der Trainingsdaten – ihr #box("Sprachverständnis beeinflussen "+cite(<brown2020languagemodelsfewshotlearners>, supplement: "S. 4")+".")
#v(-0.25em)
=== Inferenz und Prompt-basierte Interaktion
Die praktische Anwendung von #acrpl("LLM") erfolgt in der Inferenz-Phase, in der das trainierte Modell anhand eines #acr("Prompt") und auf Basis der gelernten Sprachmuster eine Ausgabe generiert #cite(<Inference>,supplement: "S. 3"). Der #acr("Prompt") fungiert dabei als zentrale Schnittstelle zwischen Nutzer und Modell und ermöglicht es, das Verhalten des #acrpl("LLM") präzise zu steuern und spezifische Kontextinformationen zu übermitteln.
Während der Inferenz verarbeitet das #acr("LLM") die Eingabe tokenweise und generiert basierend auf den Wahrscheinlichkeitsverteilungen seiner Parameter eine kohärente Antwort. Die Qualität dieser Ausgabe hängt maßgeblich vom bereitgestellt #box("Kontext ab "+cite(<LLMTaxonomyPrompting>, supplement: "S. 3-6")+".")
#pagebreak()

#import "embedding-modelle.typ": embedding-modelle
#embedding-modelle
#pagebreak()
== Vektordatenbanken
Vektordatenbanken bilden eine spezialisierte Klasse von Datenbanksystemen, die darauf ausgelegt sind, hochdimensionale Vektorrepräsentationen effizient zu speichern, zu indexieren und durchsuchbar zu machen. Im Kontext von #acr("RAG")-Systemen fungieren sie als zentrale Infrastruktur für die Speicherung und den Abruf von Embedding-Vektoren, die semantische Informationen von #box("Textdokumenten repräsentieren.")

=== Architektur und Funktionsweise
Im Gegensatz zu relationalen Datenbanken speichern Vektordatenbanken Daten als numerische Vektoren in hochdimensionalen Räumen. Jeder Vektor repräsentiert semantische Eigenschaften eines Datenobjekts, wobei die räumliche Nähe zwischen Vektoren die semantische Ähnlichkeit der ursprünglichen Inhalte widerspiegelt. Diese Eigenschaft ermöglicht komplexe Ähnlichkeitsabfragen ohne exakte #box("Schlüsselwort-Übereinstimmungen.")

Die Architektur umfasst eine Speicherschicht für persistente Vektordaten, eine Indexierungsschicht für effiziente Organisation sowie eine Abfrageschicht für Ähnlichkeitssuchen. Zusätzlich unterstützen moderne Systeme die Speicherung von Metadaten für hybride Filterung und #box("Verfeinerung der Suchergebnisse.")

=== Indexierung und Suchoptimierung
Für die effiziente Durchsuchung großer Vektorbestände setzen Vektordatenbanken spezialisierte Indexierungsalgorithmen ein. Hierarchical Navigable Small World (HNSW)-Graphen ermöglichen durch mehrschichtige Navigationsstrukturen sublineare Suchzeiten bei hoher Genauigkeit. Alternative Verfahren wie Locality-Sensitive Hashing (LSH) bieten je nach Anwendungsfall spezifische Vorteile hinsichtlich Speichereffizienz oder Suchgeschwindigkeit.
Die Approximate Nearest Neighbor (ANN)-Suche bildet das methodische Fundament dieser Verfahren. Da exakte Bestimmung der nächstgelegenen Nachbarn in hochdimensionalen Räumen rechnerisch aufwendig ist, approximieren diese Algorithmen die Ergebnisse mit kontrollierbarer Genauigkeit bei #box("reduzierten Rechenzeiten "+cite(<johnson2017billionscalesimilaritysearchgpus>, supplement: "S. 1, 2, 10")+".")

=== Technische Implementierung
Moderne Vektordatenbanken bieten standardisierte APIs für sowohl Batch-Import großer Dokumentenmengen als auch Echtzeitabfragen. Die Systeme unterstützen verschiedene Distanzmetriken wie Kosinus-Ähnlichkeit, Euklidische Distanz oder Dot-Product zur Berechnung der Vektorähnlichkeit. Aktuelle Implementierungen bieten zusätzlich Funktionalitäten wie versionierte Vektorbestände, horizontale Skalierung und Multi-Tenancy-Fähigkeiten für #box("unternehmenskritische Anwendungen.")


#pagebreak()
== Retrieval Augmented Generation (Tim)
#acrf("RAG") kombiniert die Stärken von #acrpl("LLM") mit dem gezielten Zugriff auf externe Wissensquellen. Klassische #acr("LLM")-Modelle schöpfen ausschließlich aus dem Trainingswissen und können aktuelle oder spezielle Informationen nicht einbeziehen #cite(<gupta2024comprehensivesurveyretrievalaugmentedgeneration>, supplement: "1"), was bei neuen oder spezialisierten Fragestellungen zu falschen oder „halluzinierten", also erfundenen, Antworten #box("führen kann "+cite(<gupta2024comprehensivesurveyretrievalaugmentedgeneration>, supplement: "1-2")+cite(<Huang_2025>, supplement: "S. 1, 3, 20")+cite(<ibm2023rag>)+".")

#acr("RAG")-Systeme hingegen durchsuchen vor jeder Antwort eine hinterlegte Wissensbasis (Dokumente, Datenbanken o. Ä.) nach relevanten Textpassagen und übergeben diese als zusätzlichen Kontext an das #acr("LLM"). So lassen sich aktuelle Fakten und spezialisierte Informationen direkt einbinden, ohne das #acr("LLM") neu trainieren zu müssen, was Präzision und Nachvollziehbarkeit deutlich #box("erhöht "+cite(<gupta2024comprehensivesurveyretrievalaugmentedgeneration>, supplement: "1-2")+ref(<RAGWorkflow>)+".")

===  Wissensabruf und Anreicherung
Im #acr("RAG")-Verfahren wird zu jeder Anfrage die Wissensbasis (z.B. Dokumentensammlung, Datenbank oder Internetsuche) nach relevanten Textpassagen durchsucht, die zusammen mit der Frage als zusätzlicher Kontext an das #acr("LLM") übergeben werden. Das #acr("LLM") kann dann die abgerufenen Fakten direkt in seine Antwort einbetten #cite(<lewis2021retrievalaugmentedgenerationknowledgeintensivenlp>, supplement: "S. 9"). So können auch aktuelle Informationen, wie neueste Forschungsergebnisse, einfließen, ohne dass das #acr("LLM") diese im Training lernen musste. Die Antworten basieren auf verifizierten Quellen und bleiben aktuell, da neue Daten einfach in die Wissensbasis aufgenommen werden können, was Qualität und Aktualität gerade bei nischen Themen #box("und neuen Erkenntnissen erhöht "+cite(<karpukhin2020densepassageretrievalopendomain>, supplement: "S. 8") +cite(<lewis2021retrievalaugmentedgenerationknowledgeintensivenlp>, supplement: "S. 9")).

=== Retrieval-Verfahren und Suchstrategien
Die Qualität des Retrievals bestimmt maßgeblich die Verlässlichkeit der #acr("RAG")-Antworten #cite(<manning2008introduction>, supplement: "S. 9"). Dokumente werden zunächst in passageartige Einheiten segmentiert und für die Suche aufbereitet. Bei klassischen Information-Retrieval-Verfahren (sparse Retrieval) kommen TF-IDF und BM25 zum Einsatz:

- *TF-IDF*: Gewichtet Terme durch Multiplikation der Termhäufigkeit mit dem inversen Dokumenthäufigkeitsmaß, sodass häufige Terme abgeschwächt und seltene Terme #box("hervorgehoben werden"+cite(<SPARCKJONES>, supplement: "S. 12, 13, 15")+cite(<BM25>,supplement: "S. 347-352")+".")
- *BM25*: Führt gesättigte Termfrequenz und Dokumentlängennormalisierung ein, um übermäßige Gewichtung und unverhältnismäßige Bevorzugung langer Dokumente #box("zu verhindern"+cite(<BM25>,supplement: "S. 352-369")+".")

Diese Verfahren zeigen robuste Leistung, stoßen jedoch bei semantisch anspruchsvollen Anfragen oder Paraphrasen an ihre Grenzen, da sie primär auf exakten #box("Wortüberlappungen beruhen "+cite(<karpukhin2020densepassageretrievalopendomain>, supplement: "S. 1")).

Modernes dichtes Retrieval (dense Retrieval) bildet Fragen und Dokument-Passagen in einen gemeinsamen Vektorraum ab. Duale Encoder (Fragen Encoder und Passagen Encoder) auf Transformer-Basis werden darauf trainiert, semantisch ähnliche Frage-Passage-Paare im Vektorraum zu verorten. Der #acr("DPR") von Karpukhin et al. #cite(<karpukhin2020densepassageretrievalopendomain>)) zeigt, dass solche Verfahren herkömmliche BM25-Systeme in der Retrieval-Genauigkeit deutlich #box("übertreffen können "+cite(<karpukhin2020densepassageretrievalopendomain>, supplement: "S. 1-3")).

Für die technische Umsetzung des dichten Retrievals werden die in Kapitel 2.2 beschriebenen Vektordatenbanken eingesetzt, die eine effiziente Speicherung und Durchsuchung der Embedding-Vektoren ermöglichen. Hybride Strategien kombinieren schnelle sparse Vorfilterung per BM25 mit dichter Feinsortierung über Vektordatenbanken, um Effizienz und Präzision zu balancieren. Metadaten können als Filterbedingung einfließen, um irrelevante oder veraltete Passagen #box("frühzeitig auszuschließen "+cite(<kuzi2020leveragingsemanticlexicalmatching>,supplement: "S. 1-4")).

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

#rag_parameter

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
#figure(caption: "RAG Workflow entlang der Komponenten" + cite(<gupta2024comprehensivesurveyretrievalaugmentedgeneration>,supplement: "S. 2"),image(width: 100%,"pictures/RAG knowledge.png"))<RAGWorkflow>