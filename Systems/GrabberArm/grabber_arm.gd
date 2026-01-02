extends Node2D
var globalId: int
const armLinkLength = 55
var heldItem

func IsPlacePositionValid(localPositionOnShip: Vector2, ship: Ship) -> bool:
	var positionInFrontOfMe = localPositionOnShip + round(Vector2.UP.rotated(rotation)) * 64
	
	var isSectionInFront = ship.PositionHasSection(positionInFrontOfMe)
	
	var isSectionOnMe = ship.PositionHasSection(localPositionOnShip)
	
	return isSectionInFront and not isSectionOnMe

func ReceiveMovement(vector: Vector2) -> void:
	if vector.length() == 0:
		return
		
	var maxLength = armLinkLength * 2 + 10
	vector = vector.rotated(-rotation)
	var newPosition = $ArmEnd.position + vector
	newPosition.x = clamp(newPosition.x, -maxLength, maxLength)
	newPosition.y = clamp(newPosition.y, 0, maxLength)
	$ArmEnd.position = newPosition

func ReceiveLook(vector: Vector2) -> void:
	if vector.length() == 0:
		return
	
	var sprite = $Skeleton2D/FirstArm/SecondArm/EndEffector/Node2D
	sprite.rotate(deg_to_rad(3) * sign(vector.x))
			
func ReceiveRightHand() -> void:
	if heldItem == null:
		PickUpItem()
	else:
		DropItem()
		
func PickUpItem() -> void:
	var reach: Area2D = $Skeleton2D/FirstArm/SecondArm/EndEffector/Node2D/Area2D
	
	var nearestArea: Area2D = null
	var minimumLength = INF
	
	var areas = reach.get_overlapping_areas()
	
	for area: Area2D in areas:
		if not area.get_parent().is_in_group("CanPickUp"):
			continue
		var distance = (area.position - $"..".position).length()
		if distance < minimumLength:
			minimumLength = distance
			nearestArea = area
	
	if nearestArea == null:
		return
	
	var creator = get_node("/root/MasterScene/Game/ContainedItemCreator")
	
	heldItem = creator.ExtractItemFromContainer(nearestArea.get_parent())
	
	$Skeleton2D/FirstArm/SecondArm/EndEffector/Node2D.add_child(heldItem)
	
func DropItem() -> void:
	var creator: ContainedItemCreator = get_tree().get_first_node_in_group("ContainedItemCreator")
	
	var ship = get_parent().get_parent()
	
	var positionToGet = $Skeleton2D/FirstArm/SecondArm/EndEffector/Node2D.to_local(ship.position)
	
	creator.SpawnItemInShip(heldItem, positionToGet, ship)
	
	$Skeleton2D/FirstArm/SecondArm/EndEffector/Node2D.remove_child(heldItem)
	
	heldItem = null
	
func GetSaveData() -> Dictionary:
	var dictionaryToSave: Dictionary
	
	dictionaryToSave["systemType"] = "grabberArm"
	dictionaryToSave["position.x"] = position.x
	dictionaryToSave["position.y"] = position.y
	dictionaryToSave["rotation"] = rotation
	dictionaryToSave["globalId"] = globalId
	
	return dictionaryToSave
