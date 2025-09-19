extends Node2D
class_name ContainedItemCreator

func CreateItemContainer(itemToContain: Node2D) -> Node2D:
	var container = load("res://Items/itemContainer.tscn").instantiate()
	
	container.ContainItem(itemToContain)
	
	return container
	
func ExtractItemFromContainer(container: ItemContainer) -> Node2D:
	var extractedItem = container.containedItem
	
	container.queue_free()
	
	return extractedItem

func SpawnItemInShip(item: Node2D, position: Vector2) -> void:
	var itemContainer = CreateItemContainer(item)
	
	$"../Ship".add_child(itemContainer)
	itemContainer.position = position
