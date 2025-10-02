extends Node2D
var globalId: int
var isOverlayingInterface
const rocketScene = preload("res://Rockets/rocket.tscn")

func ReceiveMovement(vector: Vector2) -> void:
	if $Barrel.rotation > deg_to_rad(80) and vector.x > 0:
		return
		
	if $Barrel.rotation < deg_to_rad(-80) and vector.x < 0:
		return
		
	$Barrel.rotate(deg_to_rad(3) * sign(vector.x))
	
func ReceiveEnterExit(player: Player) -> void:
	var viewPorts: PlayerViewPorts = get_tree().get_first_node_in_group("PlayerViewPorts")
	
	if isOverlayingInterface:
		var gameWorld = get_tree().get_first_node_in_group("GameWorld")
		viewPorts.SwitchToSubView(gameWorld, player.viewSide)
		isOverlayingInterface = false
	else:
		var overlay = get_tree().get_first_node_in_group("GunInterfaceOverlay")
		overlay.rotationReference = $Barrel
		overlay.rotationOffset = -rotation
		viewPorts.SwitchToSubView(overlay, player.viewSide)
		isOverlayingInterface = true
		
func ReceiveRightHand() -> void:
	var rocket: Node2D = rocketScene.instantiate()
	rocket.rotation = $Barrel.rotation + get_tree().get_first_node_in_group("Ship").rotation - rotation
	rocket.global_position = $Barrel/SpawnPosition.global_position
	var gameScene = get_tree().get_first_node_in_group("GameWorld")
	gameScene.add_child(rocket)

func GetSaveData() -> Dictionary:
	var dictionaryToSave: Dictionary = {"creator": "ExternalSystemBuilder"}
	
	dictionaryToSave["systemType"] = "gun"
	dictionaryToSave["position.x"] = position.x
	dictionaryToSave["position.y"] = position.y
	dictionaryToSave["rotation"] = rotation
	dictionaryToSave["globalId"] = globalId
	
	return dictionaryToSave
