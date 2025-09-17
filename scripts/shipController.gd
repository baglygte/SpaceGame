extends Node2D
# Contains functionality of the ship controller module

var inputManager: InputManager
var ship: RigidBody2D
var hasControl := false

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

func ReceiveInputs(inputs) -> void:
	ship.ApplyThrust(inputs)
