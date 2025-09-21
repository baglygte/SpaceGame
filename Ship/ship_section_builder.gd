extends Node2D
# Handles placing and removing of sections on the ship
class_name ShipBuilder

var sectionMap: Dictionary

func AddSectionAtPosition(section: Node2D, positionToGet: Vector2) -> void:
	$"..".add_child(section)
	section.position = positionToGet
	sectionMap[section] = positionToGet
	$WallBuilder.UpdateExternalWalls()
	
