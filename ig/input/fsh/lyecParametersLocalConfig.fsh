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
            FhirPass 0..1 and
            ClientEmail 0..1 and
            ClientId 0..1 and
            ClientSecret 0..1 and
            ClientRedirectUri 0..1 and
            ClientScope 0..1 and
            ClientRefreshToken 0..1 and
            ClientAccessToken 0..1
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
* parameter[ClientEmail].name = "client:email"
* parameter[ClientEmail].value[x] only string
* parameter[ClientEmail].valueString 1..1
* parameter[ClientEmail].part 0..0
* parameter[ClientEmail].resource 0..0
* parameter[ClientId].name = "client:id"
* parameter[ClientId].value[x] only string
* parameter[ClientId].valueString 1..1
* parameter[ClientId].part 0..0
* parameter[ClientId].resource 0..0
* parameter[ClientSecret].name = "client:secret"
* parameter[ClientSecret].value[x] only string
* parameter[ClientSecret].valueString 1..1
* parameter[ClientSecret].part 0..0
* parameter[ClientSecret].resource 0..0
* parameter[ClientRedirectUri].name = "client:redirectUri"
* parameter[ClientRedirectUri].value[x] only string  
* parameter[ClientRedirectUri].valueString 1..1
* parameter[ClientRedirectUri].part 0..0
* parameter[ClientRedirectUri].resource 0..0
* parameter[ClientScope].name = "client:scope"
* parameter[ClientScope].value[x] only string
* parameter[ClientScope].valueString 1..1
* parameter[ClientScope].part 0..0
* parameter[ClientScope].resource 0..0
* parameter[ClientRefreshToken].name = "client:refreshToken"
* parameter[ClientRefreshToken].value[x] only string
* parameter[ClientRefreshToken].valueString 1..1
* parameter[ClientRefreshToken].part 0..0
* parameter[ClientRefreshToken].resource 0..0
* parameter[ClientAccessToken].name = "client:accessToken"
* parameter[ClientAccessToken].value[x] only string
* parameter[ClientAccessToken].valueString 1..1
* parameter[ClientAccessToken].part 0..0
* parameter[ClientAccessToken].resource 0..0



// creating an instance of the profile(LyecParametersLocalConfig)
Instance:     lyec-base-config
InstanceOf:   LyecParametersLocalConfig
Title:        "Lyec Parameters Local Config Example"
Description:  "Lyec Parameters Local Config Example"
Usage:        #example
* parameter[FhirBase].valueString = "http://localhost:8080/hapi/fhir"
* parameter[FhirUser].valueString = "admin"
* parameter[FhirPass].valueString = "admin"
* parameter[ClientEmail].valueString = "xxxxx"
* parameter[ClientId].valueString = "xxxxxxx"
* parameter[ClientSecret].valueString = "xxxxx"
* parameter[ClientRedirectUri].valueString = "http://localhost:5082"
* parameter[ClientScope].valueString = "gmail"
* parameter[ClientRefreshToken].valueString = "xxxxxx"
* parameter[ClientAccessToken].valueString = "admin"
