#let prefix = "variable-state-"
#let variable = state("variables", none)

#let init-variables(variables) = {
  variable.update(variables)
}

// Check if an variable exists
#let is-valid(var) = {
  variable.display(variables => {
    if var not in variables {
      panic(var + " is not a key in the variables dictionary.")
      return false
    }
  })
  return true
}

// Display variables as clickable link
#let display-link(var, text) = {
  if is-valid(var) {
    link(label("variable-" + var), text)
  }
}

// Display variables
#let display(var, text, link: true) = {
  if link {
    display-link(var, text)
  } else {
    text
  }
}

// Display variable in short form
#let vars(var, plural: false, link: true) = {
  if plural {
    display(var, var + "s", link: link)
  } else {
    display(var, var, link: link)
  }
}
// Display acronym in short plural form
#let varspl(var, link: true) = {
  vars(var, plural: true, link: link)
}

// Display acronym in long form
#let varl(var, plural: false, link: true) = {
  variable.display(variables => {
    if is-valid(var) {
      let defs = variables.at(var)
      if type(defs) == "string" {
        if plural {
          display(var, defs + "s", link: link)
        } else {
          display(var, defs, link: link)
        }
      } else if type(defs) == "array" {
        if defs.len() == 0 {
          panic("No definitions found for variable " + var + ". Make sure it is defined in the dictionary passed to #init-variables(dict)")
        }
        if plural {
          if defs.len() == 1 {
            display(var, defs.at(0) + "s", link: link)
          } else if defs.len() == 2 {
            display(var, defs.at(1), link: link)
          } else {
            panic("Definitions should be arrays of one or two strings. Definition of " + var + " is: " + type(defs))
          }
        } else {  
          display(var, defs.at(0), link: link)
        }
      } else {
        panic("Definitions should be arrays of one or two strings. Definition of " + var + " is: " + type(defs))
      }
    }
  })
}
// Display variables in long plural form
#let varlpl(var, link: true) = {
  varl(var, plural: true, link: link)
}

// Display variables for the first time
#let varf(var, plural: false, link: true) = {
  if plural {
    display(var, [#varlpl(var) (#var\s)], link: link)
  } else {
    display(var, [#varl(var) (#var)], link: link)
  }
  state(prefix + var, false).update(true)
}
// Display variable in plural form for the first time
#let varfpl(var, link: true) = {
  varf(var, plural: true, link: link)
}

// Display variable. Expands it if used for the first time
#let var(var, plural: false, link: true) = {
  state(prefix + var, false).display(seen => {
    if seen {
      if plural {
        varspl(var, link: link)
      } else {
        vars(var, link: link)
      }
    } else {
      if plural {
        varfpl(var, link: link)
      } else {
        varf(var, link: link)
      }
    }
  })
}

// Display variables in the plural form. Expands it if used for the first time. 
#let varpl(variable, link: true) = {
  var(variable, plural: true, link: link)
}

// Print an index of all the acronyms and their definitions.
#let print-variables(variable-spacing) = {
  heading(level: 1, outlined: false, numbering: none)[Variablenverzeichnis]

  variable.display(variables=>{
    let variable-keys = variables.keys()

    let max-width = 0pt
    for var in variable-keys {
      let result = measure(var).width

      if (result > max-width) {
        max-width = result
      }
    }

    let var-list = variable-keys.sorted()

    for var in var-list{
      grid(
        columns: (max-width + 0.5em, auto),
        gutter: variable-spacing,
        [*#var#label("variable-" + var)*], [#varl(var, link: false)]
      )
    }
  })
}