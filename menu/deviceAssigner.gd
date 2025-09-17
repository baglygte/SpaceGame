extends Node2D

# Takes care of listening to device input and assign player control
# instances to the devices
#const playerController = preload("res://player/playerController.tscn")
#const playerPanelUiElement = preload("res://MainMenu/connectedPlayerPanel.tscn")
@onready var deviceDetector = $"../HBoxContainer/DetectedDevices"
var readyPlayers: Dictionary

func _input(event: InputEvent) -> void:
	if event is not InputEventJoypadButton:
		return
		
	if !event.is_action_pressed("interact"):
		return
	
	if event.device not in deviceDetector.connectedDeviceIds.keys():
		return
		
	deviceDetector.connectedDeviceIds[event.device].ToggleReady()
	
	CheckAllPlayersReady()
	
func CheckAllPlayersReady() -> void:
	for connectedDevicePanel in deviceDetector.connectedDeviceIds.values():
		if connectedDevicePanel.isReady:
			continue
		else:
			return
			
	get_tree().change_scene_to_file("res://scenes/game.tscn")
