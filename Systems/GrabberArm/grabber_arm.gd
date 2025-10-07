extends Node2D
var globalId: int
const armLinkLength = 55
var heldItem

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
	var area: PlayerReach = $Skeleton2D/FirstArm/SecondArm/EndEffector/Node2D/Area2D
	var item = area.GetNearestItemInGroup("CanPickUp")
	
	if item == null:
		return
	
	var creator = get_tree().get_first_node_in_group("ContainedItemCreator")
	
	heldItem = creator.ExtractItemFromContainer(item)
	$Skeleton2D/FirstArm/SecondArm/EndEffector/Node2D.add_child(heldItem)
	
func DropItem() -> void:
	var creator: ContainedItemCreator = get_tree().get_first_node_in_group("ContainedItemCreator")
	var positionToGet = $Skeleton2D/FirstArm/SecondArm/EndEffector/Node2D.global_position
	creator.SpawnItemInShip(heldItem, positionToGet)
	$Skeleton2D/FirstArm/SecondArm/EndEffector/Node2D.remove_child(heldItem)
	heldItem = null
	
func GetSaveData() -> Dictionary:
	var dictionaryToSave: Dictionary = {"creator": "ExternalSystemBuilder"}
	
	dictionaryToSave["systemType"] = "grabberArm"
	dictionaryToSave["position.x"] = position.x
	dictionaryToSave["position.y"] = position.y
	dictionaryToSave["rotation"] = rotation
	dictionaryToSave["globalId"] = globalId
	
	return dictionaryToSave
