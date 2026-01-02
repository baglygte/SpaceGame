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

func SpawnItemInShip(item: Node2D, itemPosition: Vector2, ship: Ship) -> void:
	var itemContainer = CreateItemContainer(item)
	
	ship.add_child(itemContainer)
	
	itemContainer.position = itemPosition

func SpawnItemInWorld(item: Node2D, itemPosition: Vector2) -> void:
	var itemContainer = CreateItemContainer(item)
	
	$"../GameWorld".add_child(itemContainer)
	
	itemContainer.position = itemPosition
	
	itemContainer.get_node("StarmapBlipConnector").Initialize("Star")
