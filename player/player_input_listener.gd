extends Node2D
class_name PlayerInputListener

# Handles the connection between device input and a given player
# such that only the device assign to the player can actually
# influence the player

var deviceId
signal moveSignal
#signal lookSignal


func AssignToPlayer(playerInstance: Player) -> void:
	reparent(playerInstance)
	playerInstance.AssignMoveSignal(moveSignal)

func _process(_delta: float) -> void:
	var leftMoveString = str(deviceId) + "_left"
	var rightMoveString = str(deviceId) + "_right"
	var upMoveString = str(deviceId) + "_up"
	var downMoveString = str(deviceId) + "_down"
	
	var movementVector = Input.get_vector(leftMoveString, rightMoveString, upMoveString, downMoveString)
	moveSignal.emit(movementVector)
	
#func _input(event) -> void:
	#canMove = event.device == deviceId
	#if event.device != deviceId:
		#return
	
