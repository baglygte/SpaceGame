extends Node2D
class_name PlayerCreator

const player = preload("res://player/player.tscn")
const cameraScene = preload("res://Player/player_camera.tscn")

var playerCount: int = 0

func CreateNewPlayers() -> void:
	
	var deviceIds = get_tree().get_first_node_in_group("GameSceneManager").persistentData["deviceIds"]
	
	while deviceIds.size() > 0:
		CreatePlayerInstance(deviceIds[0])
		
		deviceIds.remove_at(0)
		get_tree().get_first_node_in_group("GameSceneManager").persistentData["deviceIds"] = deviceIds

func CreateFromSave(variablesToSet: Dictionary) -> void:
	var deviceIds: Array = get_tree().get_first_node_in_group("GameSceneManager").persistentData["deviceIds"]
	
	var instance = CreatePlayerInstance(deviceIds[0])
	
	deviceIds.remove_at(0)
	get_tree().get_first_node_in_group("GameSceneManager").persistentData["deviceIds"] = deviceIds

	instance.position.x = variablesToSet["position.x"]
	instance.position.y = variablesToSet["position.y"]

func CreatePlayerInstance(deviceId) -> Player:
	var playerInstance = player.instantiate()
	playerCount += 1
	
	var camera = cameraScene.instantiate()
	camera.connectedPlayer = playerInstance
	playerInstance.camera = camera
	
	get_tree().root.get_node("MasterScene/Game/HUD/PlayerViewports").AddPlayerCamera(camera, playerCount)
	
	playerInstance.get_node("PlayerInputListener").deviceId = deviceId
	$"../Ship".add_child(playerInstance)
	return playerInstance
