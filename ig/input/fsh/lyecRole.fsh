Profile:        LyecRole
Parent:         Basic
Id:             lyec-role
Title:          "Lyec Role"
Description:    "Lyec Profile of the Basic resource to manage roles."
* code = LyecResourceCodeSystem#role
* extension contains
      LyecBasicName named name 1..1 MS and
      LyecRoleDescription named description 1..1 MS and 
      LyecRolePrimary named primary 1..1 and
      LyecAssignRole named role 0..* and
      LyecAssignPermission named permission 0..* 
* extension[name].valueString 1..1 MS
* extension[permission].value[x] only Reference(Basic)
* extension[permission].valueReference 1..1 MS
* extension[permission].valueReference ^label = "Permission"

// profile for lyecPermission
Profile:        LyecPermission
Parent:         Basic
Id:             lyec-permission
Title:          "Lyec Permission"
Description:    "Lyec Profile of the Basic resource to manage permissions."
* code = LyecResourceCodeSystem#permission
* extension contains
      LyecBasicName named name 1..1 MS and
      PermissionAttributes named attributes 0..1 and
      CompositePermission named compositePermission 0..*
* extension[name].valueString 1..1 MS
* extension[compositePermission].value[x] only Reference(Basic)
* extension[compositePermission].valueReference 1..1 MS
* extension[compositePermission].valueReference ^label = "Composite Permission"

// constraint invariant
Invariant:      lyec-permission-instance-constraint
Description:    "Only one of extension[instance].valueCode or extension[constraint].valueReference SHALL be present."
Expression:     "extension(url = instance).exists() xor extension(url = constraint).exists()"
Severity:       #error
XPath:          "exists(f:extension(url = instance)) != exists(f:extension(url = constraint))"

// extensions for roles and permissions
Extension:      LyecRolePrimary
Id:             lyec-role-primary
Title:          "Lyec Role Primary"
Description:    "Lyec flag for roles to indicate a primary role for assignment to users."
* ^context[1].type = #element
* ^context[1].expression = "IhrisRole"
* value[x] only boolean
* valueBoolean 1..1 

// extensions for roles assignments
Extension:      LyecAssignRole
Id:             lyec-assign-role
Title:          "Lyec Assign Role"
Description:    "Lyec Assign Role to a user or other role."
* ^context[0].type = #element
* ^context[0].expression = "Person"
* ^context[1].type = #element
* ^context[1].expression = "LyecRole"
* value[x] only Reference
* valueReference 1..1 MS
* valueReference ^label = "Role"
* valueReference only Reference(LyecRole)
* valueReference.reference ^label = "Role"


// extension for LyecRole
Extension:      LyecRoleDescription
Id:             lyec-role-description
Title:          "Lyec Role Description"
Description:    "Lyec Gives a brief description about a particular role."
* ^context[1].type = #element
* ^context[1].expression = "IhrisRole"
* value[x] only string
* valueString 1..1 MS
* valueString ^label = "Role Description"

// extension for LyecAssignPermission
Extension:      LyecAssignPermission
Id:             lyec-assign-permission
Title:          "Lyec Assign Permission"
Description:    "Lyec Assign Permission to a user or other task."
* ^context[0].type = #element
* ^context[0].expression = "LyecRole"
* value[x] only Reference
* valueReference 1..1 MS
* valueReference ^label = "Permission"
* valueReference only Reference(LyecPermission)
* valueReference.reference ^label = "Permission"

Extension:      CompositePermission
Id:             composite-permission
Title:          "Composite Permission"
Description:    "Permissions Inheritance"
* ^context[0].type = #element
* ^context[0].expression = "LyecPersmission"
* value[x] only Reference
* valueReference 1..1 MS
* valueReference ^label = "Permission"
* valueReference only Reference(LyecPermission)
* valueReference.reference ^label = "Permission"

Extension:      PermissionAttributes
Id:             permission-attributes
Title:          "Permission Attributes"
Description:    "Permission attributes."
* ^context.type = #element
* ^context.expression = "LyecPermission"
* obeys lyec-permission-instance-constraint
* extension contains
      permission 1..1 MS and
      resource 0..1 MS and
      instance 0..1 MS and
      field 0..1 MS and
      constraint 0..1 MS
* extension[permission].value[x] only code
* extension[permission].valueCode from LyecPermissionPermissionValueSet (required)
* extension[resource].value[x] only code
* extension[resource].valueCode from LyecPermissionResourceValueSet (extensible)
* extension[instance].value[x] only id
* extension[field].value[x] only string
* extension[constraint].value[x] only string


// valuesets and codesystems for permissions and roles
CodeSystem:     LyecPermissionPermissionCodeSystem
Id:             lyec-permission-permission
Title:          "Code system for permission permissions."
* ^date = "2021-03-26T09:25:04.362Z"
* ^version = "0.3.0"
* #*      "All"     "Can do any task."
* #read   "Read"    "Can read the given resource."
* #write  "Write"   "Can write the given resource."
* #delete "Delete"  "Can delete the given resource."
* #filter "Filter"  "Search filter constraints."
* #special "Special"  "Special non-resource permissions."

ValueSet:       LyecPermissionPermissionValueSet
Id:             lyec-permission-permission
Title:          "Code system for permission permissions."
* ^date = "2021-03-26T09:25:04.362Z"
* ^version = "0.3.0"
* codes from system LyecPermissionPermissionCodeSystem

CodeSystem:     LyecPermissionResourceCodeSystem
Id:             lyec-permission-resource
Title:          "Code system for permission permissions."
* ^date = "2021-03-26T09:25:04.362Z"
* ^version = "0.3.0"
* #*                    "All"
* #Practitioner         "Practitioner"
* #StructureDefinition  "StructureDefinition"
* #ValueSet             "ValueSet"
* #CodeSystem           "CodeSystem"
* #Basic                "Basic"
* #DocumentReference    "DocumentReference"
* #Organization         "Organization"
* #Questionnaire        "Questionnaire"
* #QuestionnaireResponse "QuestionnaireResponse"
* #PractitionerRole     "PractitionerRole"
* #Location             "Location"
* #Person               "Person"
* #navigation           "Navigation"

ValueSet:       LyecPermissionResourceValueSet
Id:             lyec-permission-resource
Title:          "Code system for permission permissions."
* ^date = "2021-03-26T09:25:04.362Z"
* ^version = "0.3.0"
* codes from system LyecPermissionResourceCodeSystem


// roles instances
// open role usable by anyone
Instance:       lyec-role-open
InstanceOf:     LyecRole
Title:          "Lyec Open Role"
Usage:          #example
* code = LyecResourceCodeSystem#role
* extension[name].valueString = "Open Role"
* extension[description].valueString = "This is an open role usable by all users"
* extension[primary].valueBoolean = true
* extension[permission][0].valueReference = Reference(Basic/lyec-permission-read-structure-definition)
* extension[permission][1].valueReference = Reference(Basic/lyec-permission-read-code-system)
* extension[permission][2].valueReference = Reference(Basic/lyec-permission-read-value-set)
* extension[permission][3].valueReference = Reference(Basic/lyec-permission-read-document-reference)

// admin role usable by admin users
Instance:       lyec-role-admin
InstanceOf:     LyecRole
Title:          "Lyec Admin Role"
Usage:          #example
* code = LyecResourceCodeSystem#role
* extension[name].valueString = "Admin Role"
* extension[description].valueString = "This is an Admin role usable by all only admin users"
* extension[primary].valueBoolean = true
* extension[permission][0].valueReference = Reference(Basic/lyec-permission-all-permissions-to-everything)
* extension[role][0].valueReference = Reference(Basic/lyec-role-open)


// permissions instance
Instance:       lyec-permission-all-permissions-to-everything
InstanceOf:     LyecPermission
Title:          "Lyec Permission With All Permissions To Everything"
Usage:          #example
* code = LyecResourceCodeSystem#permission
* extension[name].valueString = " Access Everything"
* extension[attributes][0].extension[permission].valueCode = LyecPermissionPermissionCodeSystem#*
* extension[attributes][0].extension[resource].valueCode = LyecPermissionResourceCodeSystem#*

Instance:       lyec-permission-read-structure-definition
InstanceOf:     LyecPermission
Title:          "Lyec Permission To Read StructureDefinition Resource"
Usage:          #example
* code = LyecResourceCodeSystem#permission
* extension[name].valueString = "Read StructureDefinition"
* extension[attributes][0].extension[permission].valueCode = LyecPermissionPermissionCodeSystem#read
* extension[attributes][0].extension[resource].valueCode = LyecPermissionResourceCodeSystem#StructureDefinition

Instance:       lyec-permission-read-basic-resource
InstanceOf:     LyecPermission
Title:          "Lyec Permission To Read Basic resource"
Usage:          #example
* code = LyecResourceCodeSystem#permission
* extension[name].valueString = "Read Basic Resource"
* extension[attributes][0].extension[permission].valueCode = LyecPermissionPermissionCodeSystem#read
* extension[attributes][0].extension[resource].valueCode = LyecPermissionResourceCodeSystem#Basic

Instance:       lyec-permission-read-person-resource
InstanceOf:     LyecPermission
Title:          "Lyec Permission To Read Person resource"
Usage:          #example
* code = LyecResourceCodeSystem#permission
* extension[name].valueString = "Read Users"
* extension[attributes][0].extension[permission].valueCode = LyecPermissionPermissionCodeSystem#read
* extension[attributes][0].extension[resource].valueCode = LyecPermissionResourceCodeSystem#Person

Instance:       lyec-permission-read-practitioner-resource
InstanceOf:     LyecPermission
Title:          "Lyec Permission To Read Practitioner resource"
Usage:          #example
* code = LyecResourceCodeSystem#permission
* extension[name].valueString = "Read Health Workers"
* extension[attributes][0].extension[permission].valueCode = LyecPermissionPermissionCodeSystem#read
* extension[attributes][0].extension[resource].valueCode = LyecPermissionResourceCodeSystem#Practitioner

Instance:       lyec-permission-read-practitioner-role-resource
InstanceOf:     LyecPermission
Title:          "Lyec Permission To Read PractitionerRole resource"
Usage:          #example
* code = LyecResourceCodeSystem#permission
* extension[name].valueString = "Read Health Worker Roles(Job Titles)"
* extension[attributes][0].extension[permission].valueCode = LyecPermissionPermissionCodeSystem#read
* extension[attributes][0].extension[resource].valueCode = LyecPermissionResourceCodeSystem#PractitionerRole

Instance:       lyec-permission-read-location-resource
InstanceOf:     LyecPermission
Title:          "Lyec Permission To Read Location resource"
Usage:          #example
* code = LyecResourceCodeSystem#permission
* extension[name].valueString = "Read Locations(Facilities)"
* extension[attributes][0].extension[permission].valueCode = LyecPermissionPermissionCodeSystem#read
* extension[attributes][0].extension[resource].valueCode = LyecPermissionResourceCodeSystem#Location

Instance:       lyec-permission-read-organization-resource
InstanceOf:     LyecPermission
Title:          "Lyec Permission To Read Organization resource"
Usage:          #example
* code = LyecResourceCodeSystem#permission
* extension[name].valueString = "Read Organizations(Hospitals)"
* extension[attributes][0].extension[permission].valueCode = LyecPermissionPermissionCodeSystem#read
* extension[attributes][0].extension[resource].valueCode = LyecPermissionResourceCodeSystem#Organization

Instance:       lyec-permission-read-questionnaire-resource
InstanceOf:     LyecPermission
Title:          "Lyec Permission To Read Questionnaire resource"
Usage:          #example
* code = LyecResourceCodeSystem#permission
* extension[name].valueString = "Read Questionnaires"
* extension[attributes][0].extension[permission].valueCode = LyecPermissionPermissionCodeSystem#read
* extension[attributes][0].extension[resource].valueCode = LyecPermissionResourceCodeSystem#Questionnaire

Instance:       lyec-permission-read-questionnaire-response-resource
InstanceOf:     LyecPermission
Title:          "Lyec Permission To Read Questionnaire Response resource"
Usage:          #example
* code = LyecResourceCodeSystem#permission
* extension[name].valueString = "Read Questionnaire Responses"
* extension[attributes][0].extension[permission].valueCode = LyecPermissionPermissionCodeSystem#read
* extension[attributes][0].extension[resource].valueCode = LyecPermissionResourceCodeSystem#QuestionnaireResponse

Instance:       lyec-permission-read-code-system
InstanceOf:     LyecPermission
Title:          "Lyec Permission To Read CodeSystem resource"
Usage:          #example
* code = LyecResourceCodeSystem#permission
* extension[name].valueString = "Read CodeSystems"
* extension[attributes][0].extension[permission].valueCode = LyecPermissionPermissionCodeSystem#read
* extension[attributes][0].extension[resource].valueCode = LyecPermissionResourceCodeSystem#CodeSystem

Instance:       lyec-permission-read-value-set
InstanceOf:     LyecPermission
Title:          "Lyec Permission To Read Valueset Resource"
Usage:          #example
* code = LyecResourceCodeSystem#permission
* extension[name].valueString = "Read ValueSets"
* extension[attributes][0].extension[permission].valueCode = LyecPermissionPermissionCodeSystem#read
* extension[attributes][0].extension[resource].valueCode = LyecPermissionResourceCodeSystem#ValueSet

Instance:       lyec-permission-read-document-reference
InstanceOf:     LyecPermission
Title:          "Lyec Permission To Read DocumentReference"
Usage:          #example
* code = LyecResourceCodeSystem#permission
* extension[name].valueString = "Read DocumentReferences"
* extension[attributes][0].extension[permission].valueCode = LyecPermissionPermissionCodeSystem#read
* extension[attributes][0].extension[resource].valueCode = LyecPermissionResourceCodeSystem#DocumentReference
* extension[attributes][0].extension[constraint].valueString = "category.exists(coding.exists(code = 'open'))"

Instance:       lyec-permission-write-structure-definition
InstanceOf:     LyecPermission
Title:          "Lyec Permission To Write StructureDefinition Resource"
Usage:          #example
* code = LyecResourceCodeSystem#permission
* extension[name].valueString = "Write StructureDefinitions"
* extension[attributes][0].extension[permission].valueCode = LyecPermissionPermissionCodeSystem#write
* extension[attributes][0].extension[resource].valueCode = LyecPermissionResourceCodeSystem#StructureDefinition
* extension[compositePermission][0].valueReference = Reference(Basic/lyec-permission-read-structure-definition)

Instance:       lyec-permission-write-basic-resource
InstanceOf:     LyecPermission
Title:          "Lyec Permission To Write Basic resource"
Usage:          #example
* code = LyecResourceCodeSystem#permission
* extension[name].valueString = "Write Basic Resources"
* extension[attributes][0].extension[permission].valueCode = LyecPermissionPermissionCodeSystem#write
* extension[attributes][0].extension[resource].valueCode = LyecPermissionResourceCodeSystem#Basic
* extension[compositePermission][0].valueReference = Reference(Basic/lyec-permission-read-basic-resource)

Instance:       lyec-permission-write-person-resource
InstanceOf:     LyecPermission
Title:          "Lyec Permission To Write Person resource"
Usage:          #example
* code = LyecResourceCodeSystem#permission
* extension[name].valueString = "Write Users"
* extension[attributes][0].extension[permission].valueCode = LyecPermissionPermissionCodeSystem#write
* extension[attributes][0].extension[resource].valueCode = LyecPermissionResourceCodeSystem#Person
* extension[compositePermission][0].valueReference = Reference(Basic/lyec-permission-read-person-resource)

Instance:       lyec-permission-write-practitioner-resource
InstanceOf:     LyecPermission
Title:          "Lyec Permission To Write Practitioner resource"
Usage:          #example
* code = LyecResourceCodeSystem#permission
* extension[name].valueString = "Write Health Workers"
* extension[attributes][0].extension[permission].valueCode = LyecPermissionPermissionCodeSystem#write
* extension[attributes][0].extension[resource].valueCode = LyecPermissionResourceCodeSystem#Practitioner
* extension[compositePermission][0].valueReference = Reference(Basic/lyec-permission-read-practitioner-resource)

Instance:       lyec-permission-write-practitioner-role-resource
InstanceOf:     LyecPermission
Title:          "Lyec Permission To Write PractitionerRole resource"
Usage:          #example
* code = LyecResourceCodeSystem#permission
* extension[name].valueString = "Write Health Worker Roles(Job Titles)"
* extension[attributes][0].extension[permission].valueCode = LyecPermissionPermissionCodeSystem#write
* extension[attributes][0].extension[resource].valueCode = LyecPermissionResourceCodeSystem#PractitionerRole
* extension[compositePermission][0].valueReference = Reference(Basic/lyec-permission-read-practitioner-role-resource)

Instance:       lyec-permission-write-location-resource
InstanceOf:     LyecPermission
Title:          "Lyec Permission To Write Location resource"
Usage:          #example
* code = LyecResourceCodeSystem#permission
* extension[name].valueString = "Write Locations(Facilities)"
* extension[attributes][0].extension[permission].valueCode = LyecPermissionPermissionCodeSystem#write
* extension[attributes][0].extension[resource].valueCode = LyecPermissionResourceCodeSystem#Location
* extension[compositePermission][0].valueReference = Reference(Basic/lyec-permission-read-location-resource)

Instance:       lyec-permission-write-organization-resource
InstanceOf:     LyecPermission
Title:          "Lyec Permission To Write Organization resource"
Usage:          #example
* code = LyecResourceCodeSystem#permission
* extension[name].valueString = "Write Organizations(Hospitals)"
* extension[attributes][0].extension[permission].valueCode = LyecPermissionPermissionCodeSystem#write
* extension[attributes][0].extension[resource].valueCode = LyecPermissionResourceCodeSystem#Organization
* extension[compositePermission][0].valueReference = Reference(Basic/lyec-permission-read-organization-resource)

Instance:       lyec-permission-write-questionnaire-resource
InstanceOf:     LyecPermission
Title:          "Lyec Permission To Write Questionnaire resource"
Usage:          #example
* code = LyecResourceCodeSystem#permission
* extension[name].valueString = "Write Questionnaires Resource"
* extension[attributes][0].extension[permission].valueCode = LyecPermissionPermissionCodeSystem#write
* extension[attributes][0].extension[resource].valueCode = LyecPermissionResourceCodeSystem#Questionnaire
* extension[compositePermission][0].valueReference = Reference(Basic/lyec-permission-read-questionnaire-resource)

Instance:       lyec-permission-write-questionnaire-response-resource
InstanceOf:     LyecPermission
Title:          "Lyec Permission To Write Questionnaire Response resource"
Usage:          #example
* code = LyecResourceCodeSystem#permission
* extension[name].valueString = "Write Questionnaire Responses Resource"
* extension[attributes][0].extension[permission].valueCode = LyecPermissionPermissionCodeSystem#write
* extension[attributes][0].extension[resource].valueCode = LyecPermissionResourceCodeSystem#QuestionnaireResponse
* extension[compositePermission][0].valueReference = Reference(Basic/lyec-permission-read-questionnaire-response-resource)

Instance:       lyec-permission-write-code-system
InstanceOf:     LyecPermission
Title:          "Lyec Permission To Write CodeSystem resource"
Usage:          #example
* code = LyecResourceCodeSystem#permission
* extension[name].valueString = "Write CodeSystems"
* extension[attributes][0].extension[permission].valueCode = LyecPermissionPermissionCodeSystem#write
* extension[attributes][0].extension[resource].valueCode = LyecPermissionResourceCodeSystem#CodeSystem
* extension[compositePermission][0].valueReference = Reference(Basic/lyec-permission-read-code-system)

Instance:       lyec-permission-write-value-set
InstanceOf:     LyecPermission
Title:          "Lyec Permission To Write Valueset Resource"
Usage:          #example
* code = LyecResourceCodeSystem#permission
* extension[name].valueString = "Write ValueSets"
* extension[attributes][0].extension[permission].valueCode = LyecPermissionPermissionCodeSystem#write
* extension[attributes][0].extension[resource].valueCode = LyecPermissionResourceCodeSystem#ValueSet
* extension[compositePermission][0].valueReference = Reference(Basic/lyec-permission-read-value-set)

Instance:       lyec-permission-write-document-reference
InstanceOf:     LyecPermission
Title:          "Lyec Permission To Write DocumentReference"
Usage:          #example
* code = LyecResourceCodeSystem#permission
* extension[name].valueString = "Write DocumentReferences"
* extension[attributes][0].extension[permission].valueCode = LyecPermissionPermissionCodeSystem#write
* extension[attributes][0].extension[resource].valueCode = LyecPermissionResourceCodeSystem#DocumentReference
* extension[attributes][0].extension[constraint].valueString = "category.exists(coding.exists(code = 'open'))"
* extension[compositePermission][0].valueReference = Reference(Basic/lyec-permission-read-document-reference)

// users to access audit logs
Instance:       lyec-permission-navigation-users-audit-event
InstanceOf:     LyecPermission
Usage:          #example
Title:          "Lyec Permission To Navigate to Users Audit Event"
* code = LyecResourceCodeSystem#permission
* extension[name].valueString = "Access Logs"
* extension[attributes][0].extension[permission].valueCode = LyecPermissionPermissionCodeSystem#special
* extension[attributes][0].extension[resource].valueCode = LyecPermissionResourceCodeSystem#navigation
* extension[attributes][0].extension[instance].valueId = "audit"

// * extension[attributes][0].extension[instance].valueId = "users-users_search" incase u need to allow access to sub menus to the users

// users to access reports
Instance:       lyec-permission-navigation-users-reports
InstanceOf:     LyecPermission
Usage:          #example
Title:          "Lyec Permission To Navigate to Users Reports"
* code = LyecResourceCodeSystem#permission
* extension[name].valueString = "Access Health Worker Reports"
* extension[attributes][0].extension[permission].valueCode = LyecPermissionPermissionCodeSystem#special
* extension[attributes][0].extension[resource].valueCode = LyecPermissionResourceCodeSystem#navigation
* extension[attributes][0].extension[instance].valueId = "reports"

//users to access change password
Instance:       lyec-permission-navigation-users-password
InstanceOf:     LyecPermission
Usage:          #example
Title:          "Lyec Permission To Navigate to Users Password"
* code = LyecResourceCodeSystem#permission
* extension[name].valueString = "Access Change Password"
* extension[attributes][0].extension[permission].valueCode = LyecPermissionPermissionCodeSystem#special
* extension[attributes][0].extension[resource].valueCode = LyecPermissionResourceCodeSystem#navigation
* extension[attributes][0].extension[instance].valueId = "password"


// users to access user management
Instance:       lyec-permission-navigation-users-users
InstanceOf:     LyecPermission
Usage:          #example
Title:          "Lyec Permission
 To Navigate to Users Users"
* code = LyecResourceCodeSystem#permission
* extension[name].valueString = "Access User Management"
* extension[attributes][0].extension[permission].valueCode = LyecPermissionPermissionCodeSystem#special
* extension[attributes][0].extension[resource].valueCode = LyecPermissionResourceCodeSystem#navigation
* extension[attributes][0].extension[instance].valueId = "users"