extends Node2D

var globalId: int

func GetSaveData() -> Dictionary:
	var dictionaryToSave: Dictionary = {"creator": "InternalSystemBuilder"}
	
	dictionaryToSave["systemType"] = "controlseat"
	dictionaryToSave["position.x"] = global_position.x
	dictionaryToSave["position.y"] = global_position.y
	dictionaryToSave["rotation"] = rotation
	dictionaryToSave["globalId"] = globalId
	
	return dictionaryToSave

func Kill() -> void:
	$interactiveRegion.ReleaseControl()
	queue_free()
