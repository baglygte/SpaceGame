class_name SystemConnection
extends Line2D

var systemA
var systemB

func GetSaveData() -> Dictionary:
	var dictionaryToSave: Dictionary = {"creator": "ConnectionBuilder"}
	
	dictionaryToSave["systemAId"] = systemA.globalId
	dictionaryToSave["systemBId"] = systemB.globalId
	
	return dictionaryToSave
