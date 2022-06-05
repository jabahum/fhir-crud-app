Profile: LyecParametersLocalConfig
Parent: Parameters
Id: lyec-parameters-local-config
Title: "LyecParametersLocalConfig"
Description: "Lyec Parameters Local Config"
* parameter 3..3
* parameter ^slicing.discriminator.type = #pattern
* parameter ^slicing.discriminator.path = "name"
* parameter ^slicing.rules = #open
* parameter contains 
            FhirBase 1..1 and
            FhirUser 0..1 and
            FhirPass 0..1
* parameter[FhirBase].name = "fhir:baseUrl"
* parameter[FhirBase].value[x] only string
* parameter[FhirBase].valueString 1..1
* parameter[FhirBase].part 0..0
* parameter[FhirBase].resource 0..0
* parameter[FhirUser].name = "fhir:username"
* parameter[FhirUser].value[x] only string
* parameter[FhirUser].valueString 1..1
* parameter[FhirUser].part 0..0
* parameter[FhirUser].resource 0..0
* parameter[FhirPass].name = "fhir:password"
* parameter[FhirPass].value[x] only string
* parameter[FhirPass].valueString 1..1
* parameter[FhirPass].part 0..0
* parameter[FhirPass].resource 0..0

// creating an instance of the profile(LyecParametersLocalConfig)
Instance:     lyec-base-config
InstanceOf:   LyecParametersLocalConfig
Title:        "Lyec Parameters Local Config Example"
Description:  "Lyec Parameters Local Config Example"
Usage:        #example
* parameter[FhirBase].valueString = "http://localhost:8080/hapi/fhir"
* parameter[FhirUser].valueString = "admin"
* parameter[FhirPass].valueString = "admin"