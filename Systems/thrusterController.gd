extends Node2D
class_name ThrusterController

var inputManager: InputManager
var hasControl
var assignedKey: Vector2
var thrustForceMagnitude = 100

func _ready() -> void:
	$interactiveRegion.interactedWithSignal.connect(ToggleControl)
	inputManager.interactSignal.connect($interactiveRegion.InteractedWith)

func ToggleControl(player: Player) -> void:
	inputManager.ClearSignal(inputManager.moveSignal)
	
	if hasControl:
		player.AssignMoveSignal(inputManager.moveSignal)
		hasControl = false
	else:
		inputManager.moveSignal.connect(ReceiveInputs)
		hasControl = true
	
func ReceiveInputs(inputs: Vector2) -> void:
	if inputs.length() < 1:
		return
		
	var labelText = "skrt"	
	if inputs == Vector2.UP:
		labelText = "Up"
	elif inputs == Vector2.DOWN:
		labelText = "Down"
	elif inputs == Vector2.RIGHT:
		labelText = "Right"
	elif inputs == Vector2.LEFT:
		labelText = "Left"
		
	$Label.text = labelText
	
	assignedKey = inputs

func IsAssignedKey(key) -> bool:
	return assignedKey == key
	
func GetForceToApply() -> Vector2:
	var moduleRotation = get_parent().global_rotation
	var forceToApply = Vector2.UP.rotated(moduleRotation) * thrustForceMagnitude
	return forceToApply
