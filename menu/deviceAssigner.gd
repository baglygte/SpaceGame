extends Control

# Takes care of listening to device input and assign player control
# instances to the devices

@onready var deviceDetector = $HBoxContainer/DetectedDevices
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
			
	CreatePlayerControllers()
	
	get_tree().get_first_node_in_group("GameSceneManager").ChangeActiveScene("res://GameScenes/game.tscn")

func CreatePlayerControllers() -> void:
	get_tree().get_first_node_in_group("GameSceneManager").AddPersistentData({"deviceIds": deviceDetector.connectedDeviceIds.keys()})
		
