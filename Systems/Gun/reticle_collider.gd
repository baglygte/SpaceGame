extends Area2D

func _ready() -> void:
	$StarmapBlipConnector.Initialize("Reticle")

func GetValidTarget() -> Node2D:
	var areas = get_overlapping_bodies()
	
	if areas.size() < 1:
		return null
	
	return areas[0].get_parent()
	
