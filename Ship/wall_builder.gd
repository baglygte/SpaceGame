class_name WallBuilder
extends Node

const wallScene = preload("res://Sections/wall.tscn")
const sectionAngles := [-PI/2, 0, PI/2, PI]

func DeleteWallsInSection(section: Node2D) -> void:
	var sectionChildren = section.get_children()
	
	for child in sectionChildren:
		
		if not child.is_in_group("Wall"):
			continue
			
		child.queue_free()
	
func UpdateExternalWalls(ship) -> void:
	var sections = ship.GetSections()
	
	for section in sections:
		DeleteWallsInSection(section)
		
		for angle in sectionAngles:
			if HasSectionAtRotation(section.position, angle, ship):
				continue
				
			AddWallToSection(section, angle)

func HasSectionAtRotation(sectionCoordinates: Vector2, angle: float, ship: Ship) -> bool:
	var sections = ship.GetSections()
	
	for section in sections:
		var rotatedVector = Vector2(64,0).rotated(angle)
		
		var coordinates = round(sectionCoordinates + rotatedVector)

		if section.position == coordinates:
			return true
	
	return false

func AddWallToSection(section: Node2D, angle: float) -> void:
	var wall = wallScene.instantiate()
	
	wall.rotate(angle - section.rotation)
	
	section.add_child(wall)
