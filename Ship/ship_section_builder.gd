extends Node2D
class_name ShipBuilder

var sectionMap: Dictionary

func IsSectionPositionValid(positionToCheck: Vector2) -> bool:
	if IsPositionOccupied(positionToCheck):
		return false
	return true

func IsPositionOccupied(positionToCheck: Vector2) -> bool:
	return positionToCheck in sectionMap.values()
	
func AddSectionAtPosition(section: Node2D, positionToGet: Vector2) -> void:
	$"..".AddSection(section)
	section.position = positionToGet
	sectionMap[section] = positionToGet
	$WallBuilder.UpdateExternalWalls()

func CreateFromSave(variablesToSet: Dictionary) -> void:
	var instance
	match variablesToSet["systemType"]:
		"thruster":
			instance = load("res://Systems/Thruster/thruster.tscn").instantiate()
		"section":
			instance = load("res://Sections/section.tscn").instantiate()
		"starmap":
			instance = load("res://Systems/Starmap/starmap.tscn").instantiate()
		"gun":
			instance = load("res://Systems/Gun/gun.tscn").instantiate()
		"controlseat":
			instance = load("res://Systems/ControlSeat/controlSeat.tscn").instantiate()
		"flightcontrol":
			instance = load("res://Systems/FlightControl/flightControl.tscn").instantiate()

	var positionToGet = Vector2(variablesToSet["position.x"], variablesToSet["position.y"])

	AddSectionAtPosition(instance, positionToGet)
