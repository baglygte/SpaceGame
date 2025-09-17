extends Node2D

# Handles the connection between device input and a given player
# such that only the device assign to the player can actually
# influence the player

var deviceId

func _input(event) -> void:
	if event.device != deviceId:
		return
