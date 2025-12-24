class_name MainHand
extends Node2D

var heldItem: Node
signal itemWasPickedUp
signal itemWasDropped
@onready var playerReach: PlayerReach = $"../PlayerReach"

func _ready() -> void:
	playerReach.AddHoverGroup("CanPickUp")
		
func Interact() -> void:
	if heldItem == null:
		PickUpItem()
		return
	
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
	
	itemWasPickedUp.emit()
	
	var playerHuds: PlayerHuds = get_tree().get_first_node_in_group("PlayerHuds")
	playerHuds.AddItemToHands(get_parent(), name, heldItem.get_node("Sprite2D").texture)

func Drop() -> void:
	if heldItem == null:
		return
		
	var creator: ContainedItemCreator = get_tree().get_first_node_in_group("ContainedItemCreator")
	var ship = get_parent().get_parent()
	creator.SpawnItemInShip(heldItem, global_position, ship)
	
	LoseItem()

func LoseItem() -> void:
	heldItem.show()
	
	if heldItem.is_in_group("Tool"):
		heldItem.Unequip()
	
	if heldItem.get_parent() == self:
		remove_child(heldItem)
	
	heldItem = null
	
	itemWasDropped.emit()
	
	var playerHuds: PlayerHuds = get_tree().get_first_node_in_group("PlayerHuds")
	playerHuds.RemoveItemFromHands(get_parent(), name)
