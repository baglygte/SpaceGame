extends Node2D

var globalId: int

func GetSaveData() -> Dictionary:
	var dictionaryToSave: Dictionary = {"creator": "InternalSystemBuilder"}
	
	dictionaryToSave["systemType"] = "controlseat"
	var section: Section = get_parent().get_parent()
	dictionaryToSave["position.x"] = position.x + section.position.x
	dictionaryToSave["position.y"] = position.y + section.position.y
	dictionaryToSave["rotation"] = rotation
	dictionaryToSave["globalId"] = globalId
	
	return dictionaryToSave

func Kill() -> void:
	$interactiveRegion.ReleaseControl()
	queue_free()
