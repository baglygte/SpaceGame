extends Control
class_name UIInventory

const uiItemScene = preload("res://scenes/uiItem.tscn")
var player: Player

func _ready() -> void:
	visible = false
	#$NinePatchRect.size = Vector2(500,500)
	
func AddItem(itemToAdd) -> void:
	var uiItem = uiItemScene.instantiate()
	uiItem.ContainItem(itemToAdd)
	$GridContainer.add_child(uiItem)
