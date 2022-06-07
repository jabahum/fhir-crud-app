Profile:        LyecJurisdiction
Parent:         Location
Id:             lyec-jurisdiction
Title:          "Jurisdiction"
Description:    "Lyec Profile of Locations to manage jurisdictions."
* type 1..1 MS
* type ^label = "Location Type"
* type.coding 1..1 MS
* type.coding ^label = "Location Type"
* type.coding from LyecJurisdictionType (required)
* physicalType 1..1 MS
* physicalType ^label = "Location Physical Type"
* name 1..1 MS
* name ^label = "Name"
* status 1..1 MS
* status ^label = "Status"
* partOf 0..1 MS
* partOf only Reference(LyecJurisdiction)
* partOf ^label = "Part Of(Country/Region/District/County)"


Profile:        LyecFacility
Parent:         Location
Id:             lyec-facility
Title:          "Lyec Facility"
Description:    "Lyec Profile of Locations to manage facilities."
* type 1..* MS
* type ^label = "Facilty Service Type"
* type.coding 1..1 MS
* type.coding ^label = "Facilty Service Type"
* physicalType 1..1 MS
* physicalType ^label = "Facilty Physical Type"
* name 1..1 MS
* name ^label = "Name"
* status 1..1 MS
* status ^label = "Status"
* position 0..1 MS
* position ^label = "Co-ordinates"
* position.longitude 1..1 MS
* position.longitude ^label = "Longitude"
* position.latitude 1..1 MS
* position.latitude ^label = "Latitude"
* partOf 1..1 MS 
* partOf only Reference(LyecJurisdiction)
* partOf ^label = "Part Of(Country/Region/District/County,SubCounty, etc.)"

ValueSet:         LyecJurisdictionType
Id:               lyec-jurisdiction-type
Title:            "Lyec Jurisdiction Type ValueSet"
* ^date = "2020-11-12T08:41:04.362Z"
* ^version = "0.3.0"
* codes from system LyecJurisdictionType

CodeSystem:      LyecJurisdictionType
Id:              lyec-jurisdiction-type
Title:           "Jurisdiction Type(Country/Region/District/County/SubCounty, etc.)"
* ^date = "2020-11-12T08:41:04.362Z"
* ^version = "0.3.0"
* #country "Country" "Country"
* #region "Region" "Region"
* #district "District" "District"
* #county "County" "County"
* #subcounty "Subcounty" "Subcounty"
* #parish "Parish" "Parish"
* #village "Village" "Village"



