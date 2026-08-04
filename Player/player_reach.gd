class_name PlayerReach
extends Area2D

var interactableButtons: InteractableButtons
var objectHighlight: ObjectHighlight

func _ready() -> void:
	area_exited.connect(AreaExited)

func _process(_delta: float) -> void:
	var nearestArea = GetNearestHoverArea()
	
	SetNearestHover(nearestArea)
	
	var nonNearestAreas = GetNonNearestHoverAreas(nearestArea)
	
	for area in nonNearestAreas:
		var objectHover: ObjectHover = area.get_parent().get_node("ObjectHover")
	
		objectHover.RemoveButtonsFromHUD(interactableButtons)

func SetNearestHover(nearestArea: Area2D):
	if nearestArea == null:
		return
		
	var objectHover: ObjectHover = nearestArea.get_parent().get_node("ObjectHover")
	
	objectHover.SendInteractableButtonsToHUD(interactableButtons, $"../OffHand".GetToolHoverFilter())
	
	objectHighlight.SetObjectToHighlight(get_parent(), nearestArea.get_parent())

func GetNearestHoverAreaWithFilter(hoverFilter: String) -> Area2D:
	var area = GetNearestHoverArea()
	
	if area == null:
		return area
		
	var objectHover: ObjectHover = area.get_parent().get_node("ObjectHover")
	
	if objectHover.IsValidHover(hoverFilter):
		return area
	else:
		return null

func GetNearestHoverArea() -> Area2D:
	var nearestArea: Area2D = null
	
	var distanceToNearest: float = INF
	
	for area: Area2D in get_overlapping_areas():
		if not area.name == "HoverArea":
			continue
			
		var distanceToArea = (global_position - area.global_position).length()
		
		if  distanceToArea < distanceToNearest:                      
			distanceToNearest = distanceToArea
			nearestArea = area
	
	return nearestArea
	
func GetNonNearestHoverAreas(nearestArea: Area2D) -> Array[Area2D]:
	var areas: Array[Area2D]
	
	for area: Area2D in get_overlapping_areas():
		if not area.name == "HoverArea":
			continue
			
		if area == nearestArea:
			continue
			
		areas.append(area)
	
	return areas
	
func AreaExited(area: Area2D):
	var node = area.get_parent()
	
	if not node.has_node("ObjectHover"):
		return
	
	var objectHover: ObjectHover = node.get_node("ObjectHover")
	
	objectHover.RemoveButtonsFromHUD(interactableButtons)
