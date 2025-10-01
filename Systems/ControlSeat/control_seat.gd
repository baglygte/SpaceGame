extends Node2D

var globalId: int
var playerInSeat: Player

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

func OnEnterExit(player: Player) -> void:
	
	if playerInSeat == player:
		playerInSeat = null
	elif playerInSeat == null:
		playerInSeat = player
	else:
		return
	
	$SignalEmitter.SendEnterExit(player)
