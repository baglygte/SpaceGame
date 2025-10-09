class_name SectorMapBlipConnector
extends Node2D
# Anything that should appear on the sectormap should have this scene

var blipType
signal wasKilled
var sisterBlip

func Initialize(blipTypeToGet: String) -> void:
	blipType = blipTypeToGet
	
	var sectorMapOverlay = get_tree().get_first_node_in_group("SectorMapOverlay")
	
	if sectorMapOverlay == null:
		return
	
	sectorMapOverlay.AddBlip(self)

func Kill() -> void:
	wasKilled.emit(self)
