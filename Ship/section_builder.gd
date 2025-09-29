class_name SectionBuilder
extends Node2D

var sectionMap: Dictionary
var sectionScene =  preload("res://Sections/section.tscn")

func IsSectionPositionValid(positionToCheck: Vector2) -> bool:
	if IsPositionOccupied(positionToCheck):
		return false
	return true

func IsPositionOccupied(positionToCheck: Vector2) -> bool:
	return positionToCheck in sectionMap.values()
	
func AddSectionAtPosition(section, positionToGet: Vector2, rotationToGet: float) -> void:
	add_child(section)
	section.position = positionToGet
	section.rotation = rotationToGet
	sectionMap[section] = positionToGet
	$WallBuilder.UpdateExternalWalls()
	var distance: float = ($"..".center_of_mass - section.position).length()
	$"..".inertia += section.mass * pow(distance,2)
	$"..".center_of_mass += section.position
	
	
func ExtractSectionAtPosition(positionToRemove: Vector2) -> Node2D:
	if not IsPositionOccupied(positionToRemove):
		return null
	
	for section in sectionMap.keys():
		var sectionPosition = sectionMap[section]
		
		if sectionPosition == positionToRemove:
			$"..".RemoveSection(section)
			sectionMap.erase(section)
			$WallBuilder.UpdateExternalWalls()
			return section
	
	return null
	
func CreateFromSave(variablesToSet: Dictionary) -> void:
	var section = sectionScene.instantiate()
	var positionToGet = Vector2(variablesToSet["position.x"], variablesToSet["position.y"])
	var rotationToGet = variablesToSet["rotation"]
	
	AddSectionAtPosition(section, positionToGet, rotationToGet)
