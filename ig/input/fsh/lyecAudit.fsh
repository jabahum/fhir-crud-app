Profile:        LyecAuditEvent
Parent:         AuditEvent
Id:             lyec-auditevent
Title:          "Lyec Audit Event"
Description:    "Lyec profile for AuditEvent"
* type 1..1 MS
* type ^label = "Type"
* subtype 0..1 MS
* subtype ^label = "SubType"
* action 0..1 MS
* action ^label = "Action"
* recorded 1..1 MS
* recorded ^label = "Time Recorded"
* outcome 1..1 MS
* outcome ^label = "Outcome"
* agent 1..* MS
* agent ^label = "Agent"
* agent.altId 0..1 MS
* agent.altId ^label = "User AltId"
* agent.name 0..1 MS
* agent.name ^label = "Name"
* agent.requestor 1..1 MS
* agent.requestor ^label = "Requestor"
* agent.network 0..1 MS
* agent.network ^label = "Network"
* agent.network.address 0..1 MS
* agent.network.address ^label = "Network Address"
* agent.network.type 0..1 MS
* agent.network.type ^label = "Type of Network Device"
* source 1..1 MS
* source ^label = "Audit Event Reporter"
* source.observer 1..1 MS
* source.observer ^label = "Identity Of Source"
* source.type 0..* MS
* source.type ^label = "Type of Source"
* entity 0..* MS
* entity ^label = "Entity/Data"
* entity.what 0..1 MS
* entity.what ^label = "Resource"
* entity.detail 0..* MS
* entity.detail ^label = "Additional Information"


