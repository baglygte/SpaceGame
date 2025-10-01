extends SubViewport

var rotationReference

func _ready() -> void:
	var world2D = get_tree().get_first_node_in_group("SectorMapOverlay").find_world_2d()
	$SubViewportContainer/SubViewport.world_2d = world2D

func _process(_delta: float) -> void:
	if rotationReference == null:
		return
		
	$Control.rotation = rotationReference.rotation
