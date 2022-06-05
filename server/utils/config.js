
// fhir 
const fhirAxios = require('../utils/fhirAxios');

// fhir 
const fhir = fhirAxios.setOptions({
    base: "http://localhost:8080/hapi/fhir",
    username: "admin",
    password: "admin"
})


module.exports = fhir;