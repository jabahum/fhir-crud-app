
// fhir 
const fhirAxios = require('../utils/fhirAxios');
// config
const fhirConfig = require('../utils/fhirConfig');
// nconf
const nconf = require('nconf')

nconf.argv()
    .env()

let baseConfig = fhirConfig.parseFile('./config/baseConfig.json')
nconf.add('base', { type: 'literal', store: baseConfig })
// fhir 
const fhir = fhirAxios.setOptions({
    base: nconf.get('fhir:baseUrl'),
    username: nconf.get('fhir:username'),
    password: nconf.get('fhir:password')
})


module.exports = fhir;