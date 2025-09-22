extends Node2D
class_name Hammer

var isEquipped: bool = false
var previewInstance
var ship
var player

func _ready() -> void:
	ship = get_tree().get_first_node_in_group("Ship")
	player = get_parent().get_parent()

func _process(_delta: float) -> void:
	if !isEquipped:
		return
		
	var pointedPosition = player.position + Vector2(70,0).rotated(player.rotation)
	var shipPosition = ship.global_position
	var snappedPosition: Vector2
	
	snappedPosition.x = pointedPosition.x - fmod(pointedPosition.x, 64) + shipPosition.x
	snappedPosition.y = pointedPosition.y - fmod(pointedPosition.y, 64) + shipPosition.y
	
	previewInstance.global_position = snappedPosition
	
func Equip() -> void:
	isEquipped = true
	previewInstance = load("res://section_preview.tscn").instantiate()
	player.get_node("PlayerReach").AddHoverGroup("HammerCanEdit")
	ship.add_child(previewInstance)

func Unequip() -> void:
	isEquipped = false
	player.get_node("PlayerReach").RemoveHoverGroup("HammerCanEdit")
	previewInstance.queue_free()
	
func Use() -> void:
	if not isEquipped:
		return
		
	var otherHand: Hand = get_parent().GetOtherHand()
	var item
	
	if otherHand.heldItem == null:
		item = player.get_node("PlayerReach").GetNearestItemInGroup("HammerCanEdit")

		otherHand.PutItemIntoHand(item)
		return
	
	item = otherHand.heldItem
	
	otherHand.LoseItem()

	ship.get_node("ShipSectionBuilder").AddSectionAtPosition(item, previewInstance.position)	
