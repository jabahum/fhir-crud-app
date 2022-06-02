Extension:      LyecBasicName
Id:             lyec-basic-name
Title:          "Lyec Basic Name"
Description:    "Lyec name field for basic resources."
* ^context[0].type = #element
* ^context[0].expression = "Basic"
* value[x] only string
* valueString 1..1 MS
* valueString ^label = "Name"
