#let prefix = "acronym-state-"
#let varis = state("variables", none)
#import "shared-lib.typ": display-link, is-in-dict

#let display(dict-type, state, element, text, link: false) = {
  if link {
    display-link(dict-type, state, element, text)
  } else {
    text
  }
}

#let init-variables(variables) = {
  varis.update(variables)
}

#let vars(acr, plural: false, link: true) = {
  if plural {
    display("variables", varis, acr, acr + "s", link: link)
  } else {
    display("variables", varis, acr, acr, link: link)
  }
}
#let varspl(acr, link: true) = {
  acrs(acr, plural: true, link: link)
}

#let varl(acr, plural: false, link: true) = {
  context {
    let variables = varis.get()
    if is-in-dict("variables", varis, acr) {
      let defs = variables.at(acr)
      if type(defs) == str {
        if plural {
          display("variables", varis, acr, defs + "s", link: link)
        } else {
          display("variables", varis, acr, defs, link: link)
        }
      } else if type(defs) == "array" {
        if defs.len() == 0 {
          panic("No definitions found for acronym " + acr + ". Make sure it is defined in the dictionary passed to #init-variables(dict)")
        }
        if plural {
          if defs.len() == 1 {
            display("variables", varis, acr, defs.at(0) + "s", link: link)
          } else if defs.len() == 2 {
            display("variables", varis, acr, defs.at(1), link: link)
          } else {
            panic("Definitions should be arrays of one or two strings. Definition of " + acr + " is: " + type(defs))
          }
        } else {
          display("variables", varis, acr, defs.at(0), link: link)
        }
      } else {
        panic("Definitions should be arrays of one or two strings. Definition of " + acr + " is: " + type(defs))
      }
    }
  }
}
#let varlpl(acr, link: true) = {
  varl(acr, plural: true, link: link)
}
#let varf(acr, plural: false, link: true) = {
  if plural {
    display("variables", varis, acr, [#varlpl(acr) (#acr\s)], link: link)
  } else {
    display("variables", varis, acr, [#varl(acr) ($#acr$)], link: link)
  }
  state(prefix + acr, false).update(true)
}
#let varfpl(acr, link: true) = {
  acrf(acr, plural: true, link: link)

}
#let var(acr, plural: false, link: true) = {
  context {
    let seen = state(prefix + acr, false).get()
    if seen {
      if plural {
        varpl(acr, link: link)
      } else {
        vars(acr, link: link)
      }
    } else {
      if plural {
        acrfpl(acr, link: link)
      } else {
        varf(acr, link: link)
      }
    }
  }
}
#let varpl(acronym, link: true) = {
  acr(acronym, plural: true, link: link)
}
#let print-variables(acronym-spacing) = {
  heading(level: 1, outlined: false, numbering: none)[Variablenverzeichnis]
  context {
    let variables = varis.get()
    let acronym-keys = variables.keys()
    let max-width = 0pt
    for acr in acronym-keys {
      let result = measure(acr).width
      if (result > max-width) {
        max-width = result
      }
    }
    let acr-list = acronym-keys.sorted()
    for acr in acr-list {
      grid(
        columns: (max-width + 0.5em, auto),
        gutter: acronym-spacing,
        [*#acr#label("variables-" + acr)*], [#varl(acr, link: false)],
      )
    }
  }
}