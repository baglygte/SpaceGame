extends Node2D
class_name PlayerCreator

const player = preload("res://player/player.tscn")
const cameraScene = preload("res://Player/player_camera.tscn")

var playerCount: int = 0
var playerPositionsToLoad: Array

func CreateNewPlayers() -> void:
	var deviceIds = get_tree().get_first_node_in_group("GameSceneManager").persistentData["deviceIds"]
	
	while deviceIds.size() > 0:
		CreatePlayerInstance(deviceIds[0])
		
		deviceIds.remove_at(0)
		get_tree().get_first_node_in_group("GameSceneManager").persistentData["deviceIds"] = deviceIds

func CreateFromSave(variablesToSet: Dictionary) -> void:
	var skrt = Vector2(variablesToSet["position.x"], variablesToSet["position.y"])
	playerPositionsToLoad.append(skrt)

func CreatePlayerInstance(deviceId) -> Player:
	var playerInstance: Player = player.instantiate()
	
	if playerPositionsToLoad.size() > 0:
		playerInstance.position = playerPositionsToLoad[0]
		playerPositionsToLoad.remove_at(0)
	
	playerCount += 1
	
	if playerCount == 2:
		playerInstance.viewSide = "Right"
		
	var camera = cameraScene.instantiate()
	camera.connectedPlayer = playerInstance
	
	get_tree().root.get_node("MasterScene/Game/HUD/PlayerViewports").AddPlayerCamera(camera, playerCount)
	
	playerInstance.get_node("PlayerInputListener").deviceId = deviceId
	$"../Ship".add_child(playerInstance)
	get_tree().get_first_node_in_group("HUD").CreatePlayerHands(playerInstance)
	return playerInstance
