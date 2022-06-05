const fs = require('fs')

const fhirConfig = {

  parseFile: (file) => {
    let configString = fs.readFileSync(file)
    let config = JSON.parse(configString)

    let defaults = {}
    if (config.meta && config.meta.profile
      && config.meta.profile.includes("http://lyecdevelopers.com/fhir/StructureDefinition/lyec-parameters-local-config")) {
      for (let param of config.parameter) {
        if (param.hasOwnProperty("valueString")) {
          let split = param.name.split(':')
          let last = split.pop()
          let assign = defaults
          for (let level of split) {
            if (!assign.hasOwnProperty(level)) {
              assign[level] = {}
            }
            assign = assign[level]
          }
          assign[last] = param.valueString
        }
      }
    } else {
      log.error("Invalid profile for configuration file: " + file)
    }
    return defaults
  }


}

module.exports = fhirConfig
