extends Node2D
var globalId: int
var isOverlayingInterface
const rocketScene = preload("res://Rockets/homing_rocket.tscn")
var ammunitionrecipe = null
var logNode
var lockedOnTarget: Node2D
var reticle
const reticleColliderScene = preload("res://Systems/Gun/reticleCollider.tscn")

func _ready() -> void:
	logNode = load("res://logisticNodes/logisticNode.tscn").instantiate()
	add_child(logNode)
	logNode.store.resize(5)
	logNode.itemType = "Rockets"
	reticle = reticleColliderScene.instantiate()
	get_tree().get_first_node_in_group("GameWorld").add_child(reticle)

func ReceiveMovement(vector: Vector2) -> void:
	reticle.position += vector * 100
	#if isHoming:
		#if ($LockOn/StarmapBlipConnector.sisterBlip == null):
			#$Reticle.position += 100*vector
			#return
			
	var barrelRotation = (reticle.position - global_position).angle() + rotation
	
	$Barrel.rotation = clamp(barrelRotation, -PI/2, PI/2)
	
func ReceiveEnterExit(player: Player) -> void:
	var playerHuds: PlayerHuds = get_tree().get_first_node_in_group("PlayerHuds")
	
	if isOverlayingInterface:
		playerHuds.ClearHud(player.viewSide)
		$Reticle/StarmapBlipConnector.Kill()
	else:
		playerHuds.ShowGunControlOverlay(player.viewSide, $Barrel, rotation)
		var recipes = get_tree().get_first_node_in_group("RocketRecipes")
		ammunitionrecipe = recipes.Recipes["SplitRocket"]
			
	isOverlayingInterface = !isOverlayingInterface
		
func ReceiveRightHand() -> void:
	var sectorMap = get_tree().get_first_node_in_group("SectorMapOverlay")
	
	for connection: SectorMapBlipConnector in sectorMap.blips.keys():
		if connection.blipType != "EnemyShip":
			continue
		
		var blip = sectorMap.blips[connection]
		if abs(blip.position.x - reticle.position.x)<5000:
			if abs(blip.position.y - reticle.position.y)<5000:
				lockedOnTarget = connection.get_parent()
				break

	if lockedOnTarget == null:
		return
		
		
	#if !logNode.RemoveItem():
		#return
	
	var rocket: RigidBody2D = rocketScene.instantiate()
	
	#rocket.recipe = logNode.item
	#rocket.recipe = ammunitionrecipe
	rocket.lockedOnNode = lockedOnTarget
	
	rocket.rotation = $Barrel.rotation
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
