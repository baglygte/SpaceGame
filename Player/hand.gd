extends Node2D
class_name Hand

var heldItem: Node
signal itemWasPickedUp
signal itemWasDropped
@onready var playerReach: PlayerReach = $"../PlayerReach"

func _ready() -> void:
	playerReach.AddHoverGroup("CanPickUp")

func Modify() -> void:
	if heldItem == null:
		return
	
	if heldItem is Hammer:
		heldItem.RotateSection()
	if heldItem is Wrench:
		heldItem.RotateSystem()
		
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
	var itemContainer = playerReach.GetNearestItemInGroup("CanPickUp")
	
	if itemContainer == null:
		return

	var creator = get_tree().get_first_node_in_group("ContainedItemCreator")
	
	PutItemIntoHand(creator.ExtractItemFromContainer(itemContainer))
	
func PutItemIntoHand(item) -> void:
	if item == null:
		return
	
	heldItem = item
	
	heldItem.hide()
	
	if heldItem.get_parent() == null:
		add_child(heldItem)
	else:
		heldItem.reparent(self)

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
	
	if heldItem.get_parent() == self:
		remove_child(heldItem)
	
	heldItem = null
	
	itemWasDropped.emit()
	
	SendItemToHUD()
