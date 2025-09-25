extends Node2D
class_name Hammer

var isEquipped: bool = false
var ship: Ship
var shipSectionBuilder
var player
@onready var sectionPreview = $SectionPreview

func _ready() -> void:
	ship = get_tree().get_first_node_in_group("Ship")
	shipSectionBuilder = ship.get_node("ShipSectionBuilder")

func _process(_delta: float) -> void:
	if !isEquipped:
		return
	
	var snappedPosition : Vector2
	snappedPosition.x = round(player.position.x/64)*64
	snappedPosition.y = round(player.position.y/64)*64
	
	var pointedPosition = snappedPosition + Vector2(64,0).rotated(player.rotation)
	
	sectionPreview.position.x = round(pointedPosition.x/64) * 64
	sectionPreview.position.y = round(pointedPosition.y/64) * 64
	
	var shadedColor = Vector4(255,0,0,255)
	if shipSectionBuilder.IsSectionPositionValid(snappedPosition):
		shadedColor = Vector4(0,255,0,255)
		
	sectionPreview.get_child(0).material.set("shader_parameter/shadedColor", shadedColor)
	
func Equip() -> void:
	isEquipped = true
	sectionPreview.show()
	player = get_parent().get_parent()
	player.get_node("PlayerReach").AddHoverGroup("HammerCanEdit")
	sectionPreview.reparent(ship)
	sectionPreview.rotation = 0

func Unequip() -> void:
	isEquipped = false
	sectionPreview.hide()
	player.get_node("PlayerReach").RemoveHoverGroup("HammerCanEdit")
	player = null

func Use() -> void:
	if not isEquipped:
		return
	
	if get_parent().GetOtherHand().heldItem == null:
		PickUpSection()
		return
	
	PlaceHeldSection()

func PickUpSection() -> void:
	var item = player.get_node("PlayerReach").GetNearestItemInGroup("HammerCanEdit")
	get_parent().GetOtherHand().PutItemIntoHand(item)

func PlaceHeldSection() -> void:
	if !shipSectionBuilder.IsSectionPositionValid(sectionPreview.position):
		return
		
	var otherHand: Hand = get_parent().GetOtherHand()
	var section = otherHand.heldItem
	
	otherHand.LoseItem()

	shipSectionBuilder.AddSectionAtPosition(section, sectionPreview.position)	
