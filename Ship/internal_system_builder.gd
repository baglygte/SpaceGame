class_name InternalSystemBuilder
extends Node

func CreateInternalSystem(scenePath: String) -> Node2D:
	var instance = load(scenePath).instantiate()
	instance.globalId = $"../../GlobalSystemCounter".counterValue
	
	$"../../GlobalSystemCounter".counterValue += 1
	return instance

func CreateFromSave(variablesToSet: Dictionary, section: Section) -> void:
	var instance: Node2D
	
	match variablesToSet["systemType"]:
		"controlseat":
			instance = CreateInternalSystem("res://Systems/ControlSeat/controlSeat.tscn")
		"flightcontrol":
			instance = CreateInternalSystem("res://Systems/FlightControl/flightControl.tscn")
		"ammoDepot":
			instance = CreateInternalSystem("res://Systems/AmmoDepot/ammoDepot.tscn")
			
	$"../../GlobalSystemCounter".counterValue -= 1
	
	var globalIdToGet = variablesToSet["globalId"]
	instance.globalId = globalIdToGet
	if $"../../GlobalSystemCounter".counterValue <= globalIdToGet:
		$"../../GlobalSystemCounter".counterValue = globalIdToGet + 1
	
	section.AddSystem(instance)
	
	var positionToGet = Vector2(variablesToSet["position.x"], variablesToSet["position.y"])
	var rotationToGet = variablesToSet["rotation"]
	
	instance.position = positionToGet - section.position
	instance.rotation = rotationToGet - section.rotation
	
	#AddSystemAtPosition(instance, positionToGet, rotationToGet, ship)

func GetSystemFromId(id: int, ship: Ship) -> Node2D:
	var system = null
	
	for section: Section in ship.GetSections():
		system = section.GetSystemFromId(id)
		
		if system != null:
			break
	
	return system
	
func AddSystemAtPosition(system, positionToGet, rotationToGet, ship) -> void:		
	var section: Section = GetSectionAtPosition(positionToGet, ship)
	
	section.AddSystem(system)
	
	system.position = positionToGet - section.position
	system.rotation = rotationToGet - section.rotation
		
func IsSystemPositionValid(positionToCheck: Vector2, ship: Ship) -> bool:
	return GetSectionAtPosition(positionToCheck, ship) != null

func GetSectionAtPosition(positionToCheck: Vector2, ship: Ship) -> Section:
	for section: Section in ship.GetSections():
		if section.IsPositionOnMe(positionToCheck):
			return section
	return null
