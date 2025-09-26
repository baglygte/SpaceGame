class_name Hammer
extends Node2D

var isEquipped: bool = false
var ship: Ship
var sectionBuilder: SectionBuilder
var player: Player
@onready var sectionPreview = $SectionPreview
const previewTexture = preload("res://sprites/sectionPreview.png")

const previewOffsetMap: Dictionary = {-180: Vector2(-64,0),
										-135: Vector2(-64,-64),
										-90: Vector2(0,-64),
										-45: Vector2(64,-64),
										0: Vector2(64,0),
										45: Vector2(64,64),
										90: Vector2(0,64),
										135: Vector2(-64,64),
										180: Vector2(-64,0)}
func _ready() -> void:
	ship = get_tree().get_first_node_in_group("Ship")
	sectionBuilder = ship.get_node("SectionBuilder")

func _process(_delta: float) -> void:
	if !isEquipped:
		return
	
	var previewPosition: Vector2 = GetPreviewPosition()
	sectionPreview.position = previewPosition
	
	var shadedColor = Vector4(255,0,0,0.5)
	if sectionBuilder.IsSectionPositionValid(previewPosition):
		shadedColor = Vector4(0,255,0,0.5)
		
	sectionPreview.get_child(0).material.set("shader_parameter/shadedColor", shadedColor)

func RotateSection() -> void:
	var otherHand = get_parent().GetOtherHand()
	
	if otherHand.heldItem == null:
		return
		
	sectionPreview.rotate(deg_to_rad(90))
	
func GetPreviewPosition() -> Vector2:
	var snappedRotation : int = snapped(rad_to_deg(player.rotation), 45)
	
	var snappedPlayerPosition : Vector2
	snappedPlayerPosition.x = round(player.position.x/64)*64
	snappedPlayerPosition.y = round(player.position.y/64)*64
	
	var previewOffset: Vector2 = previewOffsetMap[snappedRotation]
	
	return snappedPlayerPosition + previewOffset

func UpdatePreviewTexture() -> void:
	var item: Node2D = get_parent().GetOtherHand().heldItem
	
	var textureToGet: Texture = null
	
	if item == null:
		textureToGet = previewTexture
	else:
		textureToGet = item.get_node("Sprite2D").texture
	
	sectionPreview.get_child(0).texture = textureToGet
	sectionPreview.show()

func Equip() -> void:
	isEquipped = true
	player = get_parent().get_parent()
	player.get_node("PlayerReach").AddHoverGroup("HammerCanEdit")
	sectionPreview.reparent(ship)
	sectionPreview.rotation = 0
	
	var otherHand = get_parent().GetOtherHand()

	UpdatePreviewTexture()
		
	otherHand.itemWasPickedUp.connect(UpdatePreviewTexture)
	otherHand.itemWasDropped.connect(UpdatePreviewTexture)
	
func Unequip() -> void:
	isEquipped = false
	sectionPreview.hide()
	player.get_node("PlayerReach").RemoveHoverGroup("HammerCanEdit")
	player = null
	var otherHand = get_parent().GetOtherHand()
	otherHand.itemWasPickedUp.disconnect(UpdatePreviewTexture)
	otherHand.itemWasDropped.disconnect(UpdatePreviewTexture)

func Use() -> void:
	if not isEquipped:
		return
	
	if get_parent().GetOtherHand().heldItem == null:
		PickUpSection()
		return
	
	PlaceHeldSection()

func PickUpSection() -> void:
	var previewPosition = GetPreviewPosition()
	
	var section = sectionBuilder.ExtractSectionAtPosition(previewPosition)
	get_parent().GetOtherHand().PutItemIntoHand(section)

func PlaceHeldSection() -> void:
	if !sectionBuilder.IsSectionPositionValid(sectionPreview.position):
		return
		
	var otherHand: Hand = get_parent().GetOtherHand()
	var section = otherHand.heldItem
	
	if not section is Section:
		return
	
	otherHand.LoseItem()

	sectionBuilder.AddSectionAtPosition(section, sectionPreview.position, sectionPreview.rotation)	
