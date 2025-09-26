extends Node2D
class_name PlayerInputListener

# Handles the connection between device input and a given player
# such that only the device assign to the player can actually
# influence the player

var deviceId
var isAssigned: bool = false

signal moveSignal
signal lookSignal
signal interactRight
signal interactLeft
signal dropRight
signal dropLeft
signal modify
signal enterexit

func _ready() -> void:
	SetDefaultInputs()
	
	enterexit.connect($"..".ToggleEnterExit)
	
func _process(_delta: float) -> void:
	SendMoveSignal()
	SendLookSignal()
	
	if Input.is_action_just_pressed("start"):
		var saveManager = get_tree().get_first_node_in_group("SaveManager")
		saveManager.SaveGame()
		
	if Input.is_action_just_pressed(str(deviceId) + "_interact_right"):
		interactRight.emit()
		
	if Input.is_action_just_pressed(str(deviceId) + "_interact_left"):
		interactLeft.emit()
		
	if Input.is_action_just_pressed(str(deviceId) + "_drop_right"):
		dropRight.emit()
		
	if Input.is_action_just_pressed(str(deviceId) + "_drop_left"):
		dropLeft.emit()
	
	if Input.is_action_just_pressed(str(deviceId) + "_enterexit"):
		enterexit.emit()
	
	if Input.is_action_just_pressed(str(deviceId) + "_modify"):
		modify.emit()

func SendMoveSignal() -> void:
	var prefix = str(deviceId) + "_move"
	var leftString = prefix + "_left"
	var rightString = prefix + "_right"
	var upString = prefix + "_up"
	var downString = prefix + "_down"
	
	var movementVector = Input.get_vector(leftString, rightString, upString, downString)
	moveSignal.emit(movementVector)

func SendLookSignal() -> void:
	var prefix = str(deviceId) + "_look"
	var leftString = prefix + "_left"
	var rightString = prefix + "_right"
	var upString = prefix + "_up"
	var downString = prefix + "_down"
	
	var lookVector = Input.get_vector(leftString, rightString, upString, downString)
	lookSignal.emit(lookVector)
	
#func _input(event) -> void:
	#canMove = event.device == deviceId
	#if event.device != deviceId:
		#return

func SetDefaultInputs() -> void:
	ResetInputs()
	
	moveSignal.connect($"..".ReceiveMovement)
	lookSignal.connect($"..".ReceiveLook)
	
	interactRight.connect($"../RightHand".Interact)
	interactLeft.connect($"../LeftHand".Interact)
	
	dropRight.connect($"../RightHand".Drop)
	dropLeft.connect($"../LeftHand".Drop)
	
	modify.connect($"../RightHand".Modify)
	modify.connect($"../LeftHand".Modify)

func ResetInputs() -> void:
	ClearInputSignal(moveSignal)
	ClearInputSignal(lookSignal)
	ClearInputSignal(interactRight)
	ClearInputSignal(interactLeft)
	ClearInputSignal(dropRight)
	ClearInputSignal(dropLeft)
	ClearInputSignal(modify)

func ClearInputSignal(signalToClear: Signal) -> void:
	for connection in signalToClear.get_connections():
		signalToClear.disconnect(connection["callable"])
