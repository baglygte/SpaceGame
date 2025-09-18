extends Node2D
class_name PlayerInputListener

# Handles the connection between device input and a given player
# such that only the device assign to the player can actually
# influence the player

var deviceId
var isAssigned: bool = false
signal moveSignal
signal lookSignal

func AssignToPlayer(playerInstance: Player) -> void:
	assert(!isAssigned, "Listener is already assigned")
	
	isAssigned = true
	reparent(playerInstance)
	playerInstance.AssignMoveSignal(moveSignal)
	lookSignal.connect(playerInstance.ReceiveLook)
	#print("hej")

func _process(_delta: float) -> void:
	SendMoveSignal()
	SendLookSignal()
	
	if Input.is_action_just_pressed("start"):
		var saveManager = get_tree().get_first_node_in_group("SaveManager")
		saveManager.SaveGame()

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
	
