class_name SectormapBlipConnector
extends Node2D
# Anything that should appear on the starmap shouuld have this scene

func _ready() -> void:
	var hud: HUD = get_tree().get_first_node_in_group("HUD")
	var overlay: SectormapOverlay = hud.get_node("HBoxContainer/LeftPlayerOverlay/SectormapOverlay")
		
	overlay.AddBlip(self)

func Kill() -> void:
	var hud: HUD = get_tree().get_first_node_in_group("HUD")
	var overlay: SectormapOverlay = hud.get_node("HBoxContainer/LeftPlayerOverlay/SectormapOverlay")
		
	overlay.RemoveBlip(self)
