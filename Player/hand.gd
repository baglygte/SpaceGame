extends Node2D
class_name Hand

var heldItem: Node2D
signal itemWasPickedUp

func Interact() -> void:
	if heldItem == null:
		PickUpItem()
		return
		
	if heldItem.is_in_group("Tool"):
		heldItem.Use()
	
func Drop() -> void:
	if heldItem == null:
		return
	
	DropItem()
	
func PickUpItem() -> void:
	var itemContainer = $"../ReachCollider".GetItemWithinReach()
	
	if itemContainer == null:
		return

	var creator = get_tree().get_first_node_in_group("ContainedItemCreator")
	
	heldItem = creator.ExtractItemFromContainer(itemContainer)
	
	heldItem.hide()
	
	add_child(heldItem)

	if heldItem.is_in_group("Tool"):
		heldItem.Equip()
	
	itemWasPickedUp.emit()
	
	SendItemToHUD()

func DropItem() -> void:
	var creator: ContainedItemCreator = get_tree().get_first_node_in_group("ContainedItemCreator")
	creator.SpawnItemInShip(heldItem, global_position)
	
	LoseItem()

func SendItemToHUD() -> void:
	var hud: HUD = get_tree().get_first_node_in_group("HUD")
	hud.AddItemToHands(get_parent(), name, heldItem)

func GetOtherHand() -> Hand:
	if name == "LeftHand":
		return $"../RightHand"
		
	if name == "RightHand":
		return $"../LeftHand"
	
	return null
	
func LoseItem() -> void:
	heldItem.show()
	
	if heldItem.is_in_group("Tool"):
		heldItem.Unequip()
		
	remove_child(heldItem)
	
	heldItem = null
	
	SendItemToHUD()
