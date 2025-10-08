extends SubViewport

var rotationReference
var rotationOffset

#func _ready() -> void:
	#var world2D = get_tree().get_first_node_in_group("SectorMapOverlay").find_world_2d()
	#$CenterContainer/SubViewportContainer/SubViewport.world_2d = world2D
	#var camera: Camera2D = $CenterContainer/SubViewportContainer/SubViewport/Camera2D
	#camera.position = get_tree().get_first_node_in_group("SectorMapOverlay").size/2

func _process(_delta: float) -> void:
	if rotationReference == null:
		return

	$MarginContainer/Control.rotation = rotationReference.rotation + rotationOffset
	
	
	
