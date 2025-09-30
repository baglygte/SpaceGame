extends HBoxContainer

func _ready() -> void:
	var world2D = $SubViewportContainerLeft/SubViewport.find_world_2d()
	$SubViewportContainerRight/SubViewport.world_2d = world2D
	
func AddPlayerCamera(camera, playerCount) -> void:
	if playerCount == 1:
		$SubViewportContainerLeft/SubViewport.add_child.call_deferred(camera)
	elif playerCount == 2:
		$SubViewportContainerRight/SubViewport.add_child.call_deferred(camera)
	
