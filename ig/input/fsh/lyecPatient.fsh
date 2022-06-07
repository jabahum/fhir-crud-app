Profile: LyecPatient
Parent: Patient
Id: lyec-patient
Title: "Lyec Patient"
Description: "Lyec profile of Patient."
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
* photo 0..1 MS
* photo ^label = "Photo"
* birthDate MS
* birthDate ^label = "Birth Date"
* birthDate obeys lyec-age-18
* birthDate ^minValueQuantity.system = "http://unitsofmeasure.org/"
* birthDate ^minValueQuantity.code = #a
* birthDate ^minValueQuantity.value = 100
* birthDate ^maxValueQuantity.system = "http://unitsofmeasure.org/"
* birthDate ^maxValueQuantity.code = #a
* birthDate ^maxValueQuantity.value = -18