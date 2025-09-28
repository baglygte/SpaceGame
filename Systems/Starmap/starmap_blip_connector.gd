class_name StarmapBlipConnector
extends Node2D
# Anything that should appear on the starmap shouuld have this scene

func _ready() -> void:
	var starmap: Starmap = get_tree().get_first_node_in_group("Starmap")
	
	if starmap == null:
		return
		
	starmap.AddBlipToMap(get_parent())

func Kill() -> void:
	var starmap: Starmap = get_tree().get_first_node_in_group("Starmap")

	if starmap == null:
		return
		
	starmap.RemoveBlipFromMap(get_parent())
