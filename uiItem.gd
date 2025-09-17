extends Control
# An item in the UI. An object is contained
# in this item and will have an icon
# associated with it
class_name UIItem

var containedItem

func ContainItem(itemToContain) -> void:
	containedItem = itemToContain
	var containedItemHeight = containedItem.get_child(0).texture.get_height()
	$TextureRect.texture = containedItem.get_child(0).texture
	$TextureRect.scale = Vector2.ONE * 50.0/containedItemHeight

func ButtonClicked() -> void:
	get_parent().get_parent().player.playerInventory.PickupItem(containedItem)
	queue_free()
	return
