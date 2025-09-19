extends Node2D
class_name PlayerCreator

const player = preload("res://player/player.tscn")

func CreateNewPlayers() -> void:
	var deviceIds = $"..".gameSceneManager.persistentData["deviceIds"]
	
	while deviceIds.size() > 0:
		CreatePlayerInstance(deviceIds[0])
		
		deviceIds.remove_at(0)
		$"..".gameSceneManager.persistentData["deviceIds"] = deviceIds

func CreateFromSave(variablesToSet: Dictionary) -> void:
	var deviceIds: Array = $"..".gameSceneManager.persistentData["deviceIds"]
	
	var instance = CreatePlayerInstance(deviceIds[0])
	
	deviceIds.remove_at(0)
	$"..".gameSceneManager.persistentData["deviceIds"] = deviceIds

	instance.position.x = variablesToSet["position.x"]
	instance.position.y = variablesToSet["position.y"]

func CreatePlayerInstance(deviceId) -> Player:
	var instance = player.instantiate()
	instance.get_node("PlayerInputListener").deviceId = deviceId
		
	$"../Ship".add_child(instance)
	$"../HUD".CreatePlayerHands(instance)
	return instance
