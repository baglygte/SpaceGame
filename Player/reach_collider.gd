extends Area2D

func GetItemWithinReach() -> Node2D:
	var areas = get_overlapping_areas()
	
	if areas.size() < 1:
		return null
	
	var itemContainer: Node2D = areas[0].get_parent()
	
	if "CanPickUp" not in itemContainer.get_groups():
		return null
	
	return itemContainer
