class_name PlayerViewPorts
extends HBoxContainer

var leftCamera: Camera2D
var rightCamera: Camera2D

func _ready() -> void:
	SwitchToSubView($"../../GameWorld", "Left")
	SwitchToSubView($"../../GameWorld", "Right")
	
func AddPlayerCamera(camera, playerCount) -> void:
	if playerCount == 1:
		$LeftPlayerView/SubViewport.add_child.call_deferred(camera)
		leftCamera = camera
	elif playerCount == 2:
		$RightPlayerView/SubViewport.add_child.call_deferred(camera)
		rightCamera = camera
	
func SwitchToSubView(subViewToGet: SubViewport, side: String) -> void:
	var playerSubView: SubViewport
	var playerCamera: Camera2D
	
	if side == "Left":
		playerSubView = $LeftPlayerView/SubViewport
		playerCamera = leftCamera
	elif side == "Right":
		playerSubView = $RightPlayerView/SubViewport
		playerCamera = rightCamera
	else:
		return

	playerSubView.world_2d = subViewToGet.find_world_2d()
	subViewToGet.size = playerSubView.get_parent().size
	
	if playerCamera == null:
		return
		
	if subViewToGet.is_in_group("GameWorld"):
		playerCamera.enabled = true
	else:
		playerCamera.enabled = false
