extends Tool
class_name Hammer

var previewInstance
var ship
var player

func _ready() -> void:
	ship = get_tree().get_first_node_in_group("Ship")
	player = get_parent().get_parent().get_parent()

func OnProcess() -> void:
	var pointedPosition = player.position + Vector2(70,0).rotated(player.rotation)
	var shipPosition = ship.global_position
	var snappedPosition: Vector2
	
	snappedPosition.x = pointedPosition.x - fmod(pointedPosition.x, 64) + shipPosition.x
	snappedPosition.y = pointedPosition.y - fmod(pointedPosition.y, 64) + shipPosition.y
	
	previewInstance.global_position = snappedPosition
	
func OnEquip() -> void:
	previewInstance = load("res://section_preview.tscn").instantiate()
	player.get_node("PlayerReach").AddHoverGroup("HammerCanEdit")
	ship.add_child(previewInstance)

func OnUnequip() -> void:
	player.get_node("PlayerReach").RemoveHoverGroup("HammerCanEdit")
	previewInstance.queue_free()
	
func OnUse() -> void:
	var otherHand: Hand = get_parent().get_parent().GetOtherHand()
	
	if otherHand.heldItem == null:
		return
	
	var item = otherHand.heldItem
	
	otherHand.LoseItem()

	ship.get_node("ShipSectionBuilder").AddSectionAtPosition(item, previewInstance.position)	
