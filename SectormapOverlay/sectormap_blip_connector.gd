class_name SectormapBlipConnector
extends Node2D
# Anything that should appear on the starmap should have this scene

func _ready() -> void:
	var overlay: SectormapOverlay = get_tree().get_first_node_in_group("SectorMapOverlay")

	overlay.AddBlip(self)

func Kill() -> void:
	var overlay: SectormapOverlay = get_tree().get_first_node_in_group("SectorMapOverlay")
		
	overlay.RemoveBlip(self)
