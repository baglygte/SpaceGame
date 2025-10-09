extends Node2D
class_name PlayerInputListener

# Handles the connection between device input and a given player
# such that only the device assign to the player can actually
# influence the player

var deviceId

signal moveSignal
signal lookSignal

signal selectToolPressed
signal selectToolReleased
signal useTool

signal interact # A
signal drop # B
signal modify # X
signal enterexit # Y

signal toggleCameraZoom

func _ready() -> void:
	SetDefaultInputs()
	
	enterexit.connect($"..".ToggleEnterExit)
	
func _process(_delta: float) -> void:
	SendMoveSignal()
	SendLookSignal()
	
	if Input.is_action_just_pressed("start"):
		var saveManager = get_tree().get_first_node_in_group("SaveManager")
		saveManager.SaveGame()
	
	if Input.is_action_just_pressed(str(deviceId) + "_use_tool"):
		useTool.emit()
		
	if Input.is_action_just_pressed(str(deviceId) + "_select_tool"):
		selectToolPressed.emit()
		
	if Input.is_action_just_released(str(deviceId) + "_select_tool"):
		selectToolReleased.emit()
	
	if Input.is_action_just_pressed(str(deviceId) + "_enterexit"):
		enterexit.emit()
	
	if Input.is_action_just_pressed(str(deviceId) + "_modify"):
		modify.emit()
		
	if Input.is_action_just_pressed(str(deviceId) + "_toggle_camera_zoom"):
		toggleCameraZoom.emit()
	
	if Input.is_action_just_pressed(str(deviceId) + "_drop"):
		drop.emit()
		
	if Input.is_action_just_pressed(str(deviceId) + "_interact"):
		interact.emit()

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

func SetDefaultInputs() -> void:
	ClearAllSignals()
	
	moveSignal.connect($"..".ReceiveMovement)
	lookSignal.connect($"..".ReceiveLook)

	interact.connect($"../MainHand".Interact)
	drop.connect($"../MainHand".Drop)
	
	selectToolPressed.connect($"..".ShowWheel)
	selectToolReleased.connect($"..".HideWheel)
	useTool.connect($"../OffHand".UseHeldTool)

func ClearAllSignals() -> void:
	ClearInputSignal(moveSignal)
	ClearInputSignal(lookSignal)
	
	ClearInputSignal(interact)
	ClearInputSignal(drop)
	
	ClearInputSignal(selectToolPressed)
	ClearInputSignal(selectToolReleased)
	ClearInputSignal(useTool)

func ClearInputSignal(signalToClear: Signal) -> void:
	for connection in signalToClear.get_connections():
		signalToClear.disconnect(connection["callable"])
