extends Node2D
var globalId: int
var isOverlayingInterface
const rocketScene = preload("res://Rockets/rocket.tscn")
var ammunitionrecipe = null
var logNode
var lockedOnTarget: Node2D
var reticle
const PliersCanEdit = true
const PipewrenchCanEdit = true
var ship: Ship

func _ready() -> void:
	logNode = $LogisticNode
	logNode.store.resize(5)
	logNode.itemType = "Rockets"
	
	if get_node("/root/MasterScene/Game/GameWorld") != null:
		reticle = load("res://Systems/Gun/reticleCollider.tscn").instantiate()
		
		get_node("/root/MasterScene/Game/GameWorld").add_child(reticle)

func SetShip(shipToSet: Ship):
	ship = shipToSet
	
func IsPlacePositionValid(localPositionOnShip: Vector2) -> bool:
	var positionInFrontOfMe = localPositionOnShip + round(Vector2.UP.rotated(rotation)) * 64
	
	var isSectionInFront = ship.PositionHasSection(positionInFrontOfMe)
	
	var isSectionOnMe = ship.PositionHasSection(localPositionOnShip)
	
	return isSectionInFront and not isSectionOnMe
	
func ReceiveMovement(vector: Vector2) -> void:
	reticle.global_position += vector.rotated(ship.rotation) * 100
	
	var barrelRotation = (reticle.global_position - global_position).angle()
	
	barrelRotation += -ship.rotation - rotation - PI/2

	$Barrel.rotation = fposmod(barrelRotation, 2 * PI)
	
func ReceiveEnterExit(player: Player) -> void:
	var playerHuds: PlayerHuds = get_tree().get_first_node_in_group("PlayerHuds")
	
	if isOverlayingInterface:
		playerHuds.ClearHud(player.viewSide)
		$Reticle/StarmapBlipConnector.Kill()
	else:
		playerHuds.ShowGunControlOverlay(player.viewSide, $Barrel, ship)
		var recipes = get_tree().get_first_node_in_group("RocketRecipes")
		ammunitionrecipe = recipes.Recipes["SplitRocket"]
			
	isOverlayingInterface = !isOverlayingInterface
		
func ReceiveRightHand() -> void:
	#var sectorMap = get_tree().get_first_node_in_group("SectorMapOverlay")
	
	#for connection: SectorMapBlipConnector in sectorMap.blips.keys():
		#if connection.blipType != "EnemyShip":
			#continue
		#
		#var blip = sectorMap.blips[connection]
		#
		#if abs(blip.position.x - reticle.position.x)<5000:
			#if abs(blip.position.y - reticle.position.y)<5000:
				#lockedOnTarget = connection.get_parent()
				#break

	#if lockedOnTarget == null:
		#return

	var item = logNode.RemoveItem()
	
	if item == null:
		return
	
	var rocket: RigidBody2D = rocketScene.instantiate()
	
	rocket.recipe = item
	
	rocket.recipe = ammunitionrecipe
	
	rocket.homingTarget = lockedOnTarget
	
	rocket.rotation = $Barrel.rotation + ship.rotation - rotation
	
	rocket.global_position = $Barrel/SpawnPosition.global_position
	
	var gameScene = get_node("/root/MasterScene/Game/GameWorld")
	
	gameScene.add_child(rocket)

func GetSaveData() -> Dictionary:
	var dictionaryToSave: Dictionary
	
	dictionaryToSave["systemType"] = "gun"
	dictionaryToSave["position.x"] = position.x
	dictionaryToSave["position.y"] = position.y
	dictionaryToSave["rotation"] = rotation
	dictionaryToSave["globalId"] = globalId
	
	return dictionaryToSave
