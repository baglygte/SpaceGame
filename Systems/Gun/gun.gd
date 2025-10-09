extends Node2D
var globalId: int
var isOverlayingInterface
const rocketScene = preload("res://Rockets/rocket.tscn")
var isHoming = true
var ammunitionrecipe = null
var logNode

func _ready() -> void:
	logNode = load("res://logisticNodes/logisticNode.tscn").instantiate()
	add_child(logNode)
	logNode.store.resize(5)
	logNode.itemType = "Rockets"

func ReceiveMovement(vector: Vector2) -> void:
	if isHoming:
		if ($LockOn/StarmapBlipConnector.sisterBlip == null):
			$Reticle.position += 100*vector
			return
	if $Barrel.rotation > deg_to_rad(80) and vector.x > 0:
		return
		
	if $Barrel.rotation < deg_to_rad(-80) and vector.x < 0:
		return
		
	$Barrel.rotate(deg_to_rad(3) * sign(vector.x))
	
func ReceiveEnterExit(player: Player) -> void:
	var playerHuds: PlayerHuds = get_tree().get_first_node_in_group("PlayerHuds")
	
	if isOverlayingInterface:
		playerHuds.ClearHud(player.viewSide)
		$Reticle/StarmapBlipConnector.Kill()
	else:
		playerHuds.ShowGunControlOverlay(player.viewSide, $Barrel, rotation)
		var recipes = get_tree().get_first_node_in_group("RocketRecipes")
		ammunitionrecipe = recipes.Recipes["SplitRocket"]
		
		if isHoming:
			$Reticle/StarmapBlipConnector.Initialize("GunReticle")
			
	isOverlayingInterface = !isOverlayingInterface
		
func ReceiveRightHand() -> void:
	#if isHoming && ($LockOn/StarmapBlipConnector.sisterBlip == null):
		#$LockOn/StarmapBlipConnector.Initialize("GunLockOn")
		#$LockOn.position = $Reticle.position
		#return
	#
	#if !logNode.RemoveItem():
		#return
	
	var rocket: RigidBody2D = rocketScene.instantiate()
	#rocket.recipe = logNode.item
	
	#if isHoming:
		#rocket.homingTarget = $LockOn/StarmapBlipConnector.sisterBlip
	
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
