class_name Wrench
extends Node2D

var player: Player
var ship: Ship
var systemBuilder: SystemBuilder
var isEquipped := false
@onready var systemPreview = $SystemPreview

func _ready() -> void:
	ship = get_tree().get_first_node_in_group("Ship")
	systemBuilder = ship.get_node("SystemBuilder")
	player = get_parent().get_parent()

func _process(_delta: float) -> void:
	if !isEquipped:
		return
	
	systemPreview.position = GetPreviewPosition()
	
func GetPreviewPosition() -> Vector2:	
	return player.position + Vector2(64,0).rotated(player.rotation)

func RotateSystem() -> void:
	var otherHand = get_parent().GetOtherHand()
	
	if otherHand.heldItem == null:
		return
		
	systemPreview.rotate(deg_to_rad(90))
	
func Equip() -> void:
	isEquipped = true
	player.get_node("PlayerReach").AddHoverGroup("System")
	systemPreview.reparent(ship)
	systemPreview.rotation = 0
	
	UpdatePreviewTexture()
	
	var otherHand = get_parent().GetOtherHand()
	otherHand.itemWasPickedUp.connect(UpdatePreviewTexture)
	otherHand.itemWasDropped.connect(UpdatePreviewTexture)

func Unequip() -> void:
	isEquipped = false
	player.get_node("PlayerReach").RemoveHoverGroup("System")
	var otherHand = get_parent().GetOtherHand()
	otherHand.itemWasPickedUp.disconnect(UpdatePreviewTexture)
	otherHand.itemWasDropped.disconnect(UpdatePreviewTexture)

func UpdatePreviewTexture() -> void:
	var item: Node2D = get_parent().GetOtherHand().heldItem
	
	var textureToGet: Texture = null
	
	if item == null:
		textureToGet = null
	else:
		textureToGet = item.get_node("Sprite2D").texture
	
	systemPreview.get_child(0).texture = textureToGet
	
func Use() -> void:
	if get_parent().GetOtherHand().heldItem == null:
		PickUpSystem()
		return
	
	PlaceHeldSystem()

func PickUpSystem() -> void:
	print("PickUpSystem")

func PlaceHeldSystem() -> void:
	if !systemBuilder.IsSystemPositionValid(systemPreview.position):
		return
		
	var otherHand: Hand = get_parent().GetOtherHand()
	var item = otherHand.heldItem
	
	if not item.is_in_group("System"):
		return
	
	otherHand.LoseItem()

	systemBuilder.AddSystemAtPosition(item, systemPreview.position, systemPreview.rotation)	
