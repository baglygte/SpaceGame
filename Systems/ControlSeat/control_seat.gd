extends Node2D

var globalId: int

func GetSaveData() -> Dictionary:
	var dictionaryToSave: Dictionary = {"creator": "SystemBuilder"}
	
	dictionaryToSave["systemType"] = "controlseat"
	dictionaryToSave["position.x"] = position.x
	dictionaryToSave["position.y"] = position.y
	dictionaryToSave["rotation"] = rotation
	dictionaryToSave["globalId"] = globalId
	
	return dictionaryToSave
