class_name InternalSystemBuilder
extends Node

func CreateInternalSystem(scenePath: String) -> Node2D:
	var instance = load(scenePath).instantiate()
	instance.globalId = $"../../../GlobalSystemCounter".counterValue
	$"../../../GlobalSystemCounter".counterValue += 1
	return instance

func CreateFromSave(variablesToSet: Dictionary) -> void:
	var instance
	match variablesToSet["systemType"]:
		"controlseat":
			instance = CreateInternalSystem("res://Systems/ControlSeat/controlSeat.tscn")
		"flightcontrol":
			instance = CreateInternalSystem("res://Systems/FlightControl/flightControl.tscn")
		"ammoDepot":
			instance = CreateInternalSystem("res://Systems/AmmoDepot/ammoDepot.tscn")
			
	$"../../../GlobalSystemCounter".counterValue -= 1

	var globalIdToGet = variablesToSet["globalId"]
	instance.globalId = globalIdToGet
	if $"../../../GlobalSystemCounter".counterValue <= globalIdToGet:
		$"../../../GlobalSystemCounter".counterValue = globalIdToGet + 1
		
	var positionToGet = Vector2(variablesToSet["position.x"], variablesToSet["position.y"])
	var rotationToGet = variablesToSet["rotation"]
	
	AddSystemAtPosition(instance, positionToGet, rotationToGet)

func GetSystemFromId(id: int) -> Node2D:
	var system = null
	
	for child in $"..".get_children():
		if child is not Section:
			continue
		
		system = child.GetSystemFromId(id)
		
		if system != null:
			break
	
	return system
	
func AddSystemAtPosition(system, positionToGet, rotationToGet) -> void:		
	var section: Section = GetSectionAtPosition(positionToGet)
	
	section.AddSystem(system)
	
	system.position = positionToGet - section.position
	system.rotation = rotationToGet - section.rotation
		
func IsSystemPositionValid(positionToCheck: Vector2) -> bool:
	return GetSectionAtPosition(positionToCheck) != null

func GetSectionAtPosition(positionToCheck) -> Section:
	for node in $"..".get_children():
		if node is not Section:
			continue
		if node.IsPositionOnMe(positionToCheck):
			return node
	return null
