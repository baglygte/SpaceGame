class_name Section
extends Node2D

func GetSaveData() -> Dictionary:
	var dictionaryToSave: Dictionary = {"creator": "SectionBuilder"}
	
	dictionaryToSave["position.x"] = position.x
	dictionaryToSave["position.y"] = position.y
	dictionaryToSave["rotation"] = rotation
	
	return dictionaryToSave
