class_name PlayerReach
extends Area2D

var hoverGroups: Array

func _ready() -> void:
	area_entered.connect(AreaEntered)
	area_exited.connect(AreaExited)

func AddHoverGroup(groupName: String) -> void:
	if groupName in hoverGroups:
		return
		
	hoverGroups.append(groupName)

func RemoveHoverGroup(groupName: String) -> void:
	if groupName not in hoverGroups:
		return
	
	hoverGroups.erase(groupName)
	
	for area in get_overlapping_areas():
		if area.get_parent().is_in_group(groupName):
			area.UnrequestHover()
	
func AreaEntered(area: Area2D) -> void:
	if area is not EditableHover:
		return
		
	if not IsAreaInAnyAllowedHoverGroups(area):
		return
		
	area.RequestHover()

func AreaExited(area: Area2D) -> void:
	if area is not EditableHover:
		return
		
	if not IsAreaInAnyAllowedHoverGroups(area):
		return
		
	area.UnrequestHover()

func IsAreaInAnyAllowedHoverGroups(area: Area2D) -> bool:
	var areaIsInHoverGroups = false
	
	for groupName in hoverGroups:
		if area.get_parent().is_in_group(groupName):
			areaIsInHoverGroups = true
			break
			
	return areaIsInHoverGroups

func GetItemsInGroup(groupName: String) -> Array:
	var items = GetAllItemsWithinReach()
	var itemsToReturn: Array
	
	for item in items:
		if not item.get_parent().is_in_group(groupName):
			continue
		
		itemsToReturn.append(item.get_parent())
		
	return itemsToReturn
	
func GetItemWithinReach() -> Node2D:
	var areas = GetAllItemsWithinReach()
	
	if areas.size() < 1:
		return null
	
	var itemContainer: Node2D = areas[0].get_parent()
	
	if "CanPickUp" not in itemContainer.get_groups():
		return null
	
	return itemContainer

func GetAllItemsWithinReach() -> Array:
	return get_overlapping_areas()
