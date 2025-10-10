class_name PlayerReach
extends Area2D

var hoverGroups: Array

func WhatIsRequestingHover() -> String:
	return $"../OffHand".GetToolHoverFilter()

func AddHoverGroup(groupName: String) -> void:
	if groupName in hoverGroups:
		return
		
	hoverGroups.append(groupName)

func RemoveHoverGroup(groupName: String) -> void:
	if groupName not in hoverGroups:
		return
	
	hoverGroups.erase(groupName)
	
	for area in get_overlapping_areas():
		if not area.is_in_group("Hoverable"):
			continue
		if area.get_parent().is_in_group(groupName):
			area.UnrequestHover()
	
func AreaEntered(area: Area2D) -> void:
	if not area.is_in_group("Hoverable"):
		return
		
	if not IsAreaInAnyAllowedHoverGroups(area):
		return
		
	area.RequestHover()

func AreaExited(area: Area2D) -> void:
	if not area.is_in_group("Hoverable"):
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

func GetNearestItemInGroup(groupName: String) -> Node2D:
	var areas = FilterGroupName(get_overlapping_areas(), groupName)
	
	if areas.size() < 1:
		return null
		
	return FilterNearest(areas).get_parent()

func FilterGroupName(areas: Array, groupName: String) -> Array:
	var filteredAreas: Array
	
	for area in areas:
		if not area.get_parent().is_in_group(groupName):
			continue
		
		filteredAreas.append(area)
		
	return filteredAreas

func FilterNearest(areas: Array) -> Area2D:
	var nearestArea: Area2D
	var minimumLength = INF
	
	for area: Area2D in areas:
		var distance = (area.position - $"..".position).length()
		if distance < minimumLength:
			minimumLength = distance
			nearestArea = area
			
	return nearestArea
