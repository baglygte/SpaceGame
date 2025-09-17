extends Node2D

# Takes care of listening to device input and assign player control
# instances to the devices
const playerController = preload("res://player/playerController.tscn")
const playerPanelUiElement = preload("res://MainMenu/connectedPlayerPanel.tscn")

var readyPlayers: Dictionary
var assignedDevices: Dictionary

func _input(event: InputEvent) -> void:
	if event is not InputEventJoypadButton:
		return
		
	if !event.is_action_pressed("interact"):
		return
	
	if event.device in assignedDevices:
		SetDeviceReady(event.device)
	else:
		AddDevice(event.device)

func AddDevice(deviceId) -> void:
	var instance = playerPanelUiElement.instantiate()
	instance.SetLabelText(str(deviceId))
	get_parent().AddConnectedPlayerPanel(instance)
	
	assignedDevices[deviceId] = instance
	
	readyPlayers[deviceId] = false

func SetDeviceReady(deviceId) -> void:
	if readyPlayers[deviceId]:
		readyPlayers[deviceId] = false
		assignedDevices[deviceId].SetNotReadyPanelColor()
	else:
		readyPlayers[deviceId] = true	
		assignedDevices[deviceId].SetReadyPanelColor()
		
	if not false in readyPlayers.values():
		assert(1==0, "Create logic to go to gameplay scene. Make player controller logic. Perhaps
		make separate controllers, one for each scope. In main menu, interact would set ready state
		in game, it would do something different")
		print("All players ready")
