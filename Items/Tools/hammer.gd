extends Node2D
class_name Hammer

var isEquipped: bool = false
var previewInstance
var ship

func _ready() -> void:
	ship = get_tree().get_first_node_in_group("Ship")

func _process(_delta: float) -> void:
	if !isEquipped:
		return
		
	var player = get_parent().get_parent()
	var pointedPosition = player.position + Vector2(70,0).rotated(player.rotation)
	var shipPosition = ship.global_position
	var snappedPosition: Vector2
	
	snappedPosition.x = pointedPosition.x - fmod(pointedPosition.x, 64) + shipPosition.x
	snappedPosition.y = pointedPosition.y - fmod(pointedPosition.y, 64) + shipPosition.y
	
	previewInstance.global_position = snappedPosition

func OtherHandPickedUpItem() -> void:
	print("skrt")
	
func Equip() -> void:
	isEquipped = true
	previewInstance = load("res://section_preview.tscn").instantiate()
	get_parent().GetOtherHand().itemWasPickedUp.connect(OtherHandPickedUpItem)
	ship.add_child(previewInstance)

func Unequip() -> void:
	isEquipped = false
	get_parent().GetOtherHand().itemWasPickedUp.disconnect(OtherHandPickedUpItem)
	previewInstance.queue_free()
	
func Use() -> void:
	var otherHand: Hand = get_parent().GetOtherHand()
	
	if otherHand.heldItem == null:
		return
	
	var item = otherHand.heldItem
	
	otherHand.LoseItem()

	ship.add_child(item)
	item.position = previewInstance.position
	
