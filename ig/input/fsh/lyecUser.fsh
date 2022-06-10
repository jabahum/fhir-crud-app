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
* name.use MS
* name.use ^label = "Use"
* name.text 1..1 MS
* name.text ^label = "Fullname"
* name.family 1..1 MS
* name.family ^label = "Surname (Family)"
* name.given 1..1 MS
* name.given ^label = "Given Name (Given)"
* telecom 1..1 MS
* telecom ^label = "Email"
* telecom ^slicing.discriminator.type = #pattern
* telecom ^slicing.discriminator.path = "system"
* telecom ^slicing.rules = #open
* telecom.system MS
* telecom.system ^label = "Contact Type"
* telecom.system = #email
* telecom.value 1..1 MS
* telecom.value ^label = "Email"
* extension contains 
      LyecAssignRole named role 0..1 MS and
      LyecPassword named password 0..1 MS 
* extension[role] ^label = "Role(s)"
* extension[role].valueReference.reference MS

// password extension
Extension:      LyecPassword
Id:             lyec-password
Title:          "Lyec Password"
Description:    "Lyec password extension for local users."
* ^context.type = #element
* ^context.expression = "Person"
* extension contains 
      resetPasswordToken 1..1 MS and
      resetPasswordExpiry 1..1 MS and
      password 1..1 MS and
      salt 1..1 MS
* extension[resetPasswordToken].value[x] only string
* extension[resetPasswordToken].valueString ^label = "restPasswordToken"
* extension[resetPasswordToken].valueString 1..1 MS
* extension[resetPasswordExpiry].value[x] only string
* extension[resetPasswordExpiry].valueString ^label = "resetPasswordExpiry"
* extension[resetPasswordExpiry].valueString 1..1 MS
* extension[password].value[x] only string
* extension[password].valueString ^label = "Password"
* extension[password].valueString 1..1 MS
* extension[salt].value[x] only string
* extension[salt].valueString ^label = "Salt"
* extension[salt].valueString 1..1 MS


// instance of the Person resource / StructureDefinition
Instance:       lyec-user-admin
InstanceOf:     LyecPersonUser
Title:          "Admin User"
Usage:          #example
* telecom.value = "admin@lyecdevelopers.com"
* name.text = "Admin"
* name.family = "Admin"
* name.given = "Admin"
* identifier[0].system = "google"
* identifier[0].value = "12345"
* extension[password].extension[resetPasswordToken].valueString = "PASS"
* extension[password].extension[resetPasswordExpiry].valueString = "PASS"
* extension[password].extension[password].valueString = "PASS"
* extension[password].extension[salt].valueString = "SALT"
* extension[role][0].valueReference = Reference(Basic/lyec-role-admin)