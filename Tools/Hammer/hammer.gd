extends Tool
class_name Hammer

var sectionBuilder: SectionBuilder
@onready var sectionPreview: Node2D = $SectionPreview
const previewTexture = preload("res://sprites/sectionPreview.png")
var previewRotation = 0
var previewPosition: Vector2

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
	player = get_parent().get_parent()
	mainHand = player.get_node("MainHand")
	sectionBuilder = get_tree().get_first_node_in_group("ShipCreator").get_node("SectionBuilder")
	hoverName = "Hammer"

func _process(_delta: float) -> void:
	if !isEquipped:
		return
	
	previewPosition = GetPreviewPosition()

	sectionPreview.global_position = previewPosition
	
	sectionPreview.rotation = previewRotation - player.rotation
	
	var shadedColor = Vector4(255,0,0,0.5)
	
	var ship = player.get_parent()
	
	if sectionBuilder.IsSectionPositionValid(previewPosition, ship):
		shadedColor = Vector4(0,255,0,0.5)
		
	sectionPreview.get_child(0).material.set("shader_parameter/shadedColor", shadedColor)

func RotateSection() -> void:	
	if mainHand.heldItem == null:
		return
		
	previewRotation += PI/2
	
func GetPreviewPosition() -> Vector2:
	var ship = player.get_parent()
	
	var snappedRotation : int = snapped(rad_to_deg(player.rotation), 45)
	
	var snappedPlayerPosition : Vector2
	
	snappedPlayerPosition.x = round((ship.position.x + player.position.x/64))*64
	
	snappedPlayerPosition.y = round((ship.position.y + player.position.y/64))*64
	
	var previewOffset: Vector2 = previewOffsetMap[snappedRotation]
	
	return snappedPlayerPosition + previewOffset

func UpdatePreviewTexture() -> void:
	var textureToGet: Texture = null
	
	if mainHand.heldItem == null:
		textureToGet = previewTexture
	else:
		textureToGet = mainHand.heldItem.get_node("Sprite2D").texture
	
	sectionPreview.get_child(0).texture = textureToGet
	sectionPreview.show()

func Equip() -> void:
	isEquipped = true
	#hide()
	
	player = get_parent().get_parent()
	player.get_node("PlayerReach").AddHoverGroup("HammerCanEdit")
	#sectionPreview.reparent(ship)
	sectionPreview.rotation = 0

	UpdatePreviewTexture()
		
	mainHand.itemWasPickedUp.connect(UpdatePreviewTexture)
	mainHand.itemWasDropped.connect(UpdatePreviewTexture)
	
func Unequip() -> void:
	isEquipped = false
	#show()
	
	sectionPreview.hide()
	player.get_node("PlayerReach").RemoveHoverGroup("HammerCanEdit")
	player = null

	mainHand.itemWasPickedUp.disconnect(UpdatePreviewTexture)
	mainHand.itemWasDropped.disconnect(UpdatePreviewTexture)

func Use() -> void:
	if not isEquipped:
		return
	
	if mainHand.heldItem == null:
		PickUpSection()
		return
	
	PlaceHeldSection()

func PickUpSection() -> void:
	previewPosition = GetPreviewPosition()
	
	var ship = player.get_parent()
	
	var section = sectionBuilder.ExtractSectionAtPosition(previewPosition, ship)
	
	mainHand.PutItemIntoHand(section)

func PlaceHeldSection() -> void:
	var section = mainHand.heldItem
	
	if not section is Section:
		return
		
	var ship = player.get_parent()
	
	if !sectionBuilder.IsSectionPositionValid(GetPreviewPosition(), ship):
		return

	mainHand.LoseItem()

	sectionBuilder.AddSectionAtPosition(section, GetPreviewPosition(), previewRotation, ship)	
