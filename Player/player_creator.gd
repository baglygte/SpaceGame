extends Node2D
class_name PlayerCreator

const playerScene = preload("res://player/player.tscn")
const cameraScene = preload("res://Player/player_camera.tscn")

var playerCount: int = 0
var playerPositionsToLoad: Array

func GetAvailableDeviceId() -> int:
	var sceneManager = get_tree().get_first_node_in_group("GameSceneManager")
	var deviceId = sceneManager.persistentData["deviceIds"].pop_front()
	
	if deviceId == null:
		deviceId = -1
		
	return deviceId

func CreateNewPlayers(ship: Ship) -> void:
	var deviceId = GetAvailableDeviceId()
	
	while deviceId != -1:
		var player = CreatePlayerInstance(deviceId)
		ship.add_child(player)
		deviceId = GetAvailableDeviceId()

func CreateFromSave(variablesToSet: Dictionary) -> void:
	var deviceId = GetAvailableDeviceId()
	
	if deviceId == -1:
		return
	
	var player = CreatePlayerInstance(deviceId)
	player.position = Vector2(variablesToSet["position.x"], variablesToSet["position.y"])
	
	var shipCreator: ShipCreator = get_tree().get_first_node_in_group("ShipCreator")
	var ship = shipCreator.FindShipWithId(variablesToSet["shipId"])
	ship.add_child(player)
	
func CreatePlayerInstance(deviceId: int) -> Player:
	var player: Player = playerScene.instantiate()
	
	playerCount += 1
	
	if playerCount == 2:
		player.viewSide = "Right"
		
	var camera = cameraScene.instantiate()
	camera.connectedPlayer = player
	
	get_tree().root.get_node("MasterScene/Game/HUD/PlayerViewports").AddPlayerCamera(camera, playerCount)
	
	player.get_node("PlayerInputListener").deviceId = deviceId
	get_tree().get_first_node_in_group("HUD").CreatePlayerHud(player)
	
	return player
