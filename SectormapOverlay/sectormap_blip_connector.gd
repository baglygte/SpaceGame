class_name SectorMapBlipConnector
extends Node2D
# Anything that should appear on the starmap should have this scene

var blipType
	
func Initialize() -> void:
	var overlay: SectorMapOverlay = get_tree().get_first_node_in_group("SectorMapOverlay")

	overlay.AddBlip(self, blipType)

func Kill() -> void:
	var overlay: SectorMapOverlay = get_tree().get_first_node_in_group("SectorMapOverlay")
		
	overlay.RemoveBlip(self)
