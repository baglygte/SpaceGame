class_name Wrench
extends Node2D

var player: Player
var ship: Ship
var isEquipped := false
@onready var systemPreview = $SystemPreview
var otherHandItem

func _ready() -> void:
	ship = get_tree().get_first_node_in_group("Ship")
	player = get_parent().get_parent()
	$InternalSystemBuilderConnection.initialize()
	$ExternalSystemBuilderConnection.initialize()

func _process(_delta: float) -> void:
	if !isEquipped:
		return
	
	if otherHandItem == null:
		return
	
	if otherHandItem.is_in_group("InternalSystem"):
		$InternalSystemBuilderConnection.UpdatePreviewPosition(systemPreview)
	elif otherHandItem.is_in_group("ExternalSystem"):
		$ExternalSystemBuilderConnection.UpdatePreviewPosition(systemPreview)

func Equip() -> void:
	isEquipped = true
	
	player.get_node("PlayerReach").AddHoverGroup("InternalSystem")
	player.get_node("PlayerReach").AddHoverGroup("ExternalSystem")
	
	systemPreview.reparent(ship)
	systemPreview.show()
	systemPreview.rotation = 0
	
	var otherHand = get_parent().GetOtherHand()
	otherHand.itemWasPickedUp.connect(UpdatePickedItem)
	otherHand.itemWasDropped.connect(UpdatePickedItem)
	UpdatePickedItem()
	
func SetPreviewShaderColor(isSystemPositionValid: bool) -> void:
	var shadedColor
	if isSystemPositionValid:
		shadedColor = Vector4(0.387, 0.9, 0.592, 0.5)
	else:
		shadedColor = Vector4(1.0, 0.18, 0.317, 0.5)
	
	var sprite: Sprite2D = systemPreview.get_node("Sprite2D")
	sprite.material.set("shader_parameter/shadedColor", shadedColor)

func Unequip() -> void:
	isEquipped = false
	
	player.get_node("PlayerReach").RemoveHoverGroup("InternalSystem")
	player.get_node("PlayerReach").RemoveHoverGroup("ExternalSystem")
	
	systemPreview.reparent(self)
	systemPreview.hide()
	
	var otherHand = get_parent().GetOtherHand()
	otherHand.itemWasPickedUp.disconnect(UpdatePickedItem)
	otherHand.itemWasDropped.disconnect(UpdatePickedItem)

func UpdatePickedItem() -> void:
	otherHandItem = get_parent().GetOtherHand().heldItem
	systemPreview.rotation = 0
	UpdatePreviewTexture()

func Use() -> void:
	if otherHandItem == null:
		PickUpSystem()
		return
	
	if otherHandItem.is_in_group("InternalSystem"):
		$InternalSystemBuilderConnection.PlaceHeldSystem(otherHandItem, systemPreview.rotation)
	elif otherHandItem.is_in_group("ExternalSystem"):
		$ExternalSystemBuilderConnection.PlaceHeldSystem(otherHandItem, systemPreview.rotation)

func RotateSystem() -> void:
	systemPreview.rotate(PI/2)

func PickUpSystem() -> void:
	print("PickUpSystem")

func UpdatePreviewTexture() -> void:
	var textureToGet: Texture = null
	
	if otherHandItem == null:
		textureToGet = null
	else:
		textureToGet = otherHandItem.get_node("Sprite2D").texture
	
	systemPreview.get_child(0).texture = textureToGet
