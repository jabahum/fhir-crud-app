Profile:        LyecRole
Parent:         Basic
Id:             lyec-role
Title:          "Lyec Role"
Description:    "Lyec Profile of the Basic resource to manage roles."
* code = LyecResourceCodeSystem#role
* extension contains
      LyecBasicName named name 1..1 MS and
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