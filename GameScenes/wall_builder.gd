extends Node2D

const wallScene = preload("res://Sections/wall.tscn")

func UpdateExternalWalls() -> void:
	var sectionMap = $"..".sectionMap
	
	for section in sectionMap.keys():
		var sectionChildren = section.get_children()
		for child in sectionChildren:
			if not child.is_in_group("Wall"):
				continue
			child.queue_free()
		
		if not HasSectionAbove(sectionMap[section]):
			var wall = wallScene.instantiate()
			wall.RotateToUp()
			section.add_child(wall)
			
		if not HasSectionOnRight(sectionMap[section]):
			var wall = wallScene.instantiate()
			wall.RotateToRight()
			section.add_child(wall)
			
		if not HasSectionBelow(sectionMap[section]):
			var wall = wallScene.instantiate()
			wall.RotateToDown()
			section.add_child(wall)
			
		if not HasSectionOnLeft(sectionMap[section]):
			var wall = wallScene.instantiate()
			wall.RotateToLeft()
			section.add_child(wall)

func HasSectionAbove(sectionCoordinates: Vector2) -> bool:
	var sectionMap = $"..".sectionMap
	
	var coordinatesAbove = sectionCoordinates + Vector2(0,-64)
	
	return coordinatesAbove in sectionMap.values()

func HasSectionOnRight(sectionCoordinates: Vector2) -> bool:
	var sectionMap = $"..".sectionMap
	
	var coordinatesAbove = sectionCoordinates + Vector2(64,0)
	
	return coordinatesAbove in sectionMap.values()

func HasSectionBelow(sectionCoordinates: Vector2) -> bool:
	var sectionMap = $"..".sectionMap
	
	var coordinatesAbove = sectionCoordinates + Vector2(0,64)
	
	return coordinatesAbove in sectionMap.values()

func HasSectionOnLeft(sectionCoordinates: Vector2) -> bool:
	var sectionMap = $"..".sectionMap
	
	var coordinatesAbove = sectionCoordinates + Vector2(-64,0)
	
	return coordinatesAbove in sectionMap.values()
