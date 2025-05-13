#import "acronyms.typ": acronyms 
#import "acronym-lib.typ": init-acronyms, print-acronyms, acr, acrpl, acrs, acrspl, acrl, acrlpl, acrf, acrfpl

#import "variables.typ": variables
#import "variables-lib.typ": init-variables, print-variables, var, varpl, vars, varspl, varl, varlpl, varf,varfpl

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
#let title = "Optimierung von Large Language Model-basierten Datenextraktionsprozessen: Ein systematischer Ansatz zur Klassifizierung interner E-Mails"
#let nameAuthor = "Tim Christopher Eiser"

// Define header and footer content
#let header-content = {}

#let generate-footer-content(numbering) = locate(loc => {
  let all_headings = query(heading.where(level: 1).or(heading.where(level: 2)).or(heading.where(level: 3)), loc)
  let current_page = loc.page()
  
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
})

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
#align(center, text(weight: "semibold", size: title-size, "SPERRVERMERK"))

#v(small-spacing)

// Type of Thesis
#align(center, text(weight: "semibold", size: subtitle-size, "Zweite Projektarbeit"))

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
#align(center, text(weight: "medium", size: subtitle-size, nameAuthor))


#v(spacing * 2)

// Author Information
#grid(
  columns: (auto, auto),
  row-gutter: 12pt,
  column-gutter: 2.5em,

  // Date
  text(weight: "semibold", size: body-size, "Bearbeitungszeitraum:"),
  text(size: body-size, "Datum - Datum"),

  // Student ID and Course
  text(weight: "semibold", size: body-size, "Matrikelnummer, Kurs:"),
  text(size: body-size, "Matrikelnummer, Kurs"),

  // University Course Leader
  text(weight: "semibold", size: body-size, "Studiengangleiter:"),
  text(size: body-size, "Name"),

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

  // Company Supervisor
  text(weight: "semibold", size: body-size, "Betreuer der Ausbildungsfirma:"),
  stack(
    spacing: small-spacing,
    text(size: body-size, "Name"),
    text(size: body-size, "E-Mail"),
    text(size: body-size, "Telefonnummer")
  ),

  // Spacer
  text(size: body-size, ""),
  text(size: body-size, ""),

  // University Supervisor
  text(weight: "semibold", size: body-size, "Wissenschaftliche Betreuerin:"),
  stack(
    spacing: small-spacing,
    text(size: body-size, "Name"),
    text(size: body-size, "E-Mail"),
    text(size: body-size, "Telefonnummer")
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
    right: 4cm,
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
#align(left, text("Ich versichere hiermit, dass ich meine Projektarbeit mit dem Thema: „Titel“ selbstständig verfasst und keine anderen als die angegebenen Quellen und Hilfsmittel benutzt habe. Ich versichere zudem, dass die eingereichte elektronische Fassung mit der gedruckten Fassung übereinstimmt."))

// Space for the signature
#v(7em)

// Table for "Ort, Datum" and "Unterschrift"
#grid(
  columns: (auto, auto),
  row-gutter: 1em,
  column-gutter: 12em, 
  // Left Column
  text(weight: "semibold", "____________________________"),
  // Right Column
  text(weight: "semibold", "________________________"),
  // Left Column
  text(weight: "semibold", "Ort, Datum"),
  // Right Column
  text(weight: "semibold", "Unterschrift")
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
// Abstract
//-----------------------------------------------------------------------------------
#pagebreak()
= Abstract

#grid(
  columns: (auto, auto),
  row-gutter: 18pt,
  column-gutter: 2.5em,
  text("Titel:"),
  text(title),
  
  text("Verfasser:"),
  text(nameAuthor),
  
  text("Kurs:"),
  text("WWI 23 SCB"),
  text("Ausbildungsbetrieb:"),
  text("SAP SE"),
)
#v(1.5em)
// Fasse hier die Arbeit und die Ergebnisse kurz und prägnant zusammen.



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

#show outline.entry.where(body: [Literaturverzeichnis] ): it => {
    v(12pt, weak: true)
    strong(it)
    numbering("i")
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
    right: 4cm,
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

= Einleitung
== Motivation
Die Einleitung erläutert die zunehmenden Herausforderungen bei der Bearbeitung großer Mengen unstrukturierter interner Kommunikation in Unternehmen. Ziel ist die Anwendung und Optimierung von LLMs (Large Language Models) zur Verbesserung der Effizienz und Genauigkeit der Datenextraktion und -klassifizierung in E-Mails.
== Ziel und Gang
- Zielsetzung: Systematische Optimierung der Datenextraktion und -klassifizierung durch LLMs und gezieltes Prompt Engineering.
- Gang der Untersuchung: Die Arbeit basiert auf dem CRISP-DM-Zyklus, der die Schritte von der Problemdefinition über die Datenverarbeitung und Modellierung bis zur Evaluation und praktischen Umsetzung umfasst.
#pagebreak()

= Methodik
Die Methodik beschreibt die Anwendung des CRISP-DM-Zyklus:
- Business Understanding (Geschäftsverständnis): Definition der Projektziele und des geschäftlichen Nutzens.
- Data Understanding (Datenverständnis): Analyse der verwendeten Datenquellen, insbesondere interner E-Mails.
- Data Preparation (Datenaufbereitung): Reinigung, Formatierung und Extraktion relevanter Merkmale.
- Modeling (Modellierung): Entwicklung und Anpassung von LLM-Modellen zur Datenklassifikation mit Hilfe von Prompt Engineering.
- Evaluation (Bewertung): Überprüfung und Bewertung der Modellergebnisse.
- Deployment (Einsatz): Integration des Systems in bestehende Kommunikationsprozesse.
#pagebreak()

= Grundlagen
- LLM-Technologien und ihre Funktionsweise: Erklärung der Grundlagen von Large Language Models (z.B. GPT, BERT) und ihrer Einsatzmöglichkeiten.
- Prompt Engineering: Techniken und Methoden zur Leistungsoptimierung von LLMs durch gezielte Gestaltung von Eingabeaufforderungen.
- CRISP-DM-Zyklus: Beschreibung des CRISP-DM-Frameworks als strukturierter Ansatz für datengetriebene Projekte.
#pagebreak()

= Praxis
- Datenerhebung und -aufbereitung: Sammlung und Bearbeitung von E-Mail-Daten unter Berücksichtigung des Datenschutzes, explorative Datenanalyse zur Identifikation relevanter Merkmale.
- Modellierung und Entwicklung: Implementierung und Anpassung von LLM-Modellen zur Klassifikation von E-Mails, Anwendung verschiedener Prompting-Strategien.
- Integration und Evaluierung: Einsatz des optimierten Modells und Analyse der Ergebnisse im Vergleich zu bestehenden Ansätzen.
#pagebreak()

= Diskussion
- Ergebnisse und Interpretation: Analyse der Ergebnisse und Vergleich mit bestehenden Ansätzen zur Datenextraktion und -klassifizierung.
- Kritische Bewertung: Reflexion über die Anwendung des CRISP-DM-Zyklus und Identifikation von Stärken, Schwächen und Verbesserungsmöglichkeiten.
== Einordnung der Ergebnisse
// Einordnung der Ergebnisse Text

== Herausforderungen und Limitationen 
// Herausforderungen und Limitationen Text

== Handlungsempfehlungen und zukünftige Forschung
// Handlungsempfehlungen und zukünftige Forschung Text

#pagebreak()

= Schlussbetrachtung
- Zusammenfassung der Ergebnisse: Darstellung der erreichten Verbesserungen durch LLMs.
- Ausblick: Empfehlungen für zukünftige Forschung und Weiterentwicklung von LLM-basierten Systemen zur Optimierung interner Kommunikationsprozesse.
// Schlussbetrachtung Text

== Fazit
// Fazit Text

== Ausblick
// Ausblick und zukünftige Perspektiven Text
#pagebreak()





//-----------------------------------------------------------------------------------
// Literaturverzeichnis
//-----------------------------------------------------------------------------------
#set page(
  paper: "a4",
  margin: (
    left: 2cm,
    right: 4cm,
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