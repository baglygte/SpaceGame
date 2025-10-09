class_name Wrench
extends Tool

var ship: Ship
@onready var systemPreview = $SystemPreview

func _ready() -> void:
	player = get_parent().get_parent()
	mainHand = player.get_node("MainHand")
	ship = get_tree().get_first_node_in_group("Ship")
	$InternalSystemBuilderConnection.initialize()
	$ExternalSystemBuilderConnection.initialize()

func _process(_delta: float) -> void:
	if !isEquipped:
		return
		
	if mainHand.heldItem == null:
		return
	
	if mainHand.heldItem.is_in_group("InternalSystem"):
		$InternalSystemBuilderConnection.UpdatePreviewPosition(systemPreview)
	elif mainHand.heldItem.is_in_group("ExternalSystem"):
		$ExternalSystemBuilderConnection.UpdatePreviewPosition(systemPreview)

func Equip() -> void:
	isEquipped = true
	
	player.get_node("PlayerReach").AddHoverGroup("InternalSystem")
	player.get_node("PlayerReach").AddHoverGroup("ExternalSystem")
	
	systemPreview.reparent(ship)
	systemPreview.show()
	systemPreview.rotation = 0
	
	mainHand.itemWasPickedUp.connect(UpdatePickedItem)
	mainHand.itemWasDropped.connect(UpdatePickedItem)
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

	mainHand.itemWasPickedUp.disconnect(UpdatePickedItem)
	mainHand.itemWasDropped.disconnect(UpdatePickedItem)

func UpdatePickedItem() -> void:
	systemPreview.rotation = 0
	UpdatePreviewTexture()

func Use() -> void:
	if mainHand.heldItem == null:
		PickUpSystem()
		return
	
	if mainHand.heldItem.is_in_group("InternalSystem"):
		$InternalSystemBuilderConnection.PlaceHeldSystem(mainHand.heldItem, systemPreview.rotation)
	elif mainHand.heldItem.is_in_group("ExternalSystem"):
		$ExternalSystemBuilderConnection.PlaceHeldSystem(mainHand.heldItem, systemPreview.rotation)

func RotateSystem() -> void:
	systemPreview.rotate(PI/2)

func PickUpSystem() -> void:
	print("PickUpSystem")

func UpdatePreviewTexture() -> void:
	var textureToGet: Texture = null
	
	if mainHand.heldItem == null:
		textureToGet = null
	else:
		textureToGet = mainHand.heldItem.get_node("Sprite2D").texture
	
	systemPreview.get_child(0).texture = textureToGet
