extends Node2D
# Represents the player inventory and equipment
# Handles picking up and dropping items
class_name PlayerInventory

var heldItem: Node2D
var ship

const physicalItemScene = preload("res://scenes/physicalItem.tscn")

func PickupItem(itemToPickup: Node2D) -> bool:
	var wasPickedUp = false
	
	if heldItem != null:
		return wasPickedUp
		
	print("Picked up " + itemToPickup.name)
	heldItem = itemToPickup
	
	var inHandUi = get_tree().get_first_node_in_group("inHandUi")
	inHandUi.SetInHandItem(itemToPickup)

	if itemToPickup is Module:
		ship.shipBuilder.SetHoverItem(itemToPickup)

	wasPickedUp = true
	
	return wasPickedUp
	
func DropItem(player: Player) -> void:
	if heldItem == null:
		return
	
	var physicalItem = physicalItemScene.instantiate()
	physicalItem.ContainItem(heldItem)
	physicalItem.position = player.position + Vector2(50, 0)
	ship.add_child(physicalItem)
	
	if heldItem is Module:
		ship.shipBuilder.ClearHoverItem()
		
	ClearHeldItem()

func ClearHeldItem() -> void:
	var inHandUi = get_tree().get_first_node_in_group("inHandUi")
	inHandUi.ClearInHandItem()
	
	heldItem = null
