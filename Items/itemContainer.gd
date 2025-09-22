extends Node2D
class_name ItemContainer
# An item "on the ground". An object is contained
# in this item and transferred when the physical
# item is picked up
const rotateSpeed = 2
var containedItem: Node2D

func _process(delta: float) -> void:
	$PanelContainer.rotation += (rotateSpeed * delta)

func ContainItem(itemToContain) -> void:
	containedItem = itemToContain
	$PanelContainer/TextureRect.texture = itemToContain.get_node("Sprite2D").texture
