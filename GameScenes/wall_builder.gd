extends Node2D

const wallScene = preload("res://Sections/wall.tscn")
const sectionAngles := [-PI/2, 0, PI/2, PI]

func DeleteWallsInSection(section: Node2D) -> void:
	var sectionChildren = section.get_children()
	for child in sectionChildren:
		if not child.is_in_group("Wall"):
			continue
		child.queue_free()
	
func UpdateExternalWalls() -> void:
	var sectionMap = $"..".sectionMap
	
	for section in sectionMap.keys():
		DeleteWallsInSection(section)
		
		for angle in sectionAngles:
			if HasSectionAtRotation(sectionMap[section], angle):
				continue
			AddWallToSection(section, angle)

func HasSectionAtRotation(sectionCoordinates: Vector2, angle: float) -> bool:
	var sectionMap = $"..".sectionMap
	
	var rotatedVector = round(Vector2(64,0).rotated(angle))
	var coordinates = sectionCoordinates + rotatedVector
	
	return coordinates in sectionMap.values()

func AddWallToSection(section: Node2D, angle: float) -> void:
	var wall = wallScene.instantiate()
	wall.rotate(angle - section.rotation)
	section.add_child(wall)
