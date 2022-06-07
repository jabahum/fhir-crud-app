Invariant:      lyec-age-18
Description:    "birthDate must be more than 18 years ago."
Expression:     "birthDate < today() - 18 years"
Severity:       #error

Profile:        LyecPractitioner
Parent:         Practitioner
Id:             lyec-practitioner
Title:          "Lyec Health Workers"
Description:    "Lyec profile of Practitioner."
* identifier 0..* MS
* identifier ^label = "Identifier"
* identifier ^constraint[0].key = "lyec-search-identifier"
* identifier ^constraint[0].severity = #error
* identifier ^constraint[0].expression = "'Practitioner' | 'identifier' | iif(system.exists(), system & '|' & value, value)"
* identifier ^constraint[0].human = "The identifier must be unique and another record has this identifier"
* identifier.use MS
* identifier.use ^label = "Use"
* identifier.type MS
* identifier.type ^label = "Type"
* identifier.type.coding 1..1 MS
* identifier.type.coding ^label = "Type"
* identifier.system MS
* identifier.system ^label = "System"
* identifier.value MS
* identifier.value ^label = "Value"
* name 1..* MS
* name ^label = "Name"
* name.use MS
* name.use ^label = "Use"
* name.family 1..1 MS
* name.family ^label = "Family"
* name.family ^constraint[0].key = "lyec-name-check"
* name.family ^constraint[0].severity = #error
* name.family ^constraint[0].expression = "matches('^[A-Za-z ]*$')"
* name.family ^constraint[0].human = "Name must be only text."
* name.given 1..* MS
* name.given ^label = "Given Name"
* name.prefix MS
* name.prefix ^label = "Prefix"
* name.suffix MS
* name.suffix ^label = "Suffix"
* telecom 0..* MS
* telecom ^label = "Telecom"
* telecom.system MS
* telecom.system ^label = "Contact Type"
* telecom.use MS
* telecom.use ^label = "Use"
* telecom.value MS
* telecom.value ^label = "Value"
* telecom ^constraint[0].key = "lyec-search-phone"
* telecom ^constraint[0].severity = #error
* telecom ^constraint[0].expression = "'Practitioner' | 'phonenumber' | iif(value.exists(), system & '|' & value, value)"
* telecom ^constraint[0].human = "The identifier must be unique and another record has this identifier"
* address 0..* MS
* address ^label = "Address"
* address.use MS
* address.use ^label = "Use"
* address.type MS
* address.type ^label = "Type"
* address.line 1..1 MS
* address.line ^label = "Line"
* address.city MS
* address.city ^label = "City"
* address.district MS
* address.district ^label = "District"
* address.state MS
* address.state ^label = "State"
* address.postalCode MS
* address.postalCode ^label = "Postal Code"
* address.country MS
* address.country ^label = "Country"
* gender 1..1 MS
* gender ^label = "Gender"
* birthDate MS
* birthDate ^label = "Birth Date"
* birthDate obeys lyec-age-18
* birthDate ^minValueQuantity.system = "http://unitsofmeasure.org/"
* birthDate ^minValueQuantity.code = #a
* birthDate ^minValueQuantity.value = 100
* birthDate ^maxValueQuantity.system = "http://unitsofmeasure.org/"
* birthDate ^maxValueQuantity.code = #a
* birthDate ^maxValueQuantity.value = -18
* photo 0..1 MS
* photo ^label = "Photo"
* communication 0..* MS
* communication ^label = "Communication"
* communication.coding 1..1 MS
* communication.coding ^label = "Language"
* communication.extension contains
    LyecPractitionerLanguageProficiency named proficiency 0..* MS
* communication.extension[proficiency] MS
* communication.extension[proficiency] ^label = "Language Proficiency"
* communication.extension[proficiency].extension[level].valueCoding MS
* communication.extension[proficiency].extension[type].valueCoding MS
* active 1..1 MS
* active ^label = "Active"


// extension for language proficiency
Extension:      LyecPractitionerLanguageProficiency
Id:             lyec-practitioner-language-proficiency
Title:          "Lyec Practitioner Language Proficiency"
Description:    "Lyec extension for Practitioner Language Proficiency."
* ^context.type = #element
* ^context.expression = "Practitioner"
* extension contains
    level 0..1 MS and
    type 0..* MS
* extension[level].value[x] only Coding
* extension[level].valueCoding 0..1 MS
* extension[level].valueCoding from http://terminology.hl7.org/ValueSet/v3-LanguageAbilityProficiency
* extension[level].valueCoding ^label = "Proficiency Level"
* extension[type] ^label = "Proficiency Type"
* extension[type].value[x] only Coding
* extension[type].valueCoding 0..1 MS
* extension[type].valueCoding ^label = "Proficiency Type"
* extension[type].valueCoding from http://terminology.hl7.org/ValueSet/v3-LanguageAbilityMode