Profile:        LyecPersonUser
Parent:         Person
Id:             lyec-person-user
Title:          "System User"
Description:    "Lyec profile of the Person resource to manage user access."
* name 1..1 MS
* name ^label = "Name"
* name ^slicing.discriminator.type = #pattern
* name ^slicing.discriminator.path = "use"
* name ^slicing.rules = #open
* name.use = #official
* name.text 1..1 MS
* name.text ^label = "Fullname"
* telecom 1..1 MS
* telecom ^label = "Email"
* telecom ^slicing.discriminator.type = #pattern
* telecom ^slicing.discriminator.path = "system"
* telecom ^slicing.rules = #open
* telecom.system = #email
* telecom.value 1..1 MS
* telecom.value ^label = "Email"