class_name SystemBuilder
extends Node2D

var globalSystemIdCounter: int = 1
func IsSystemPositionValid(positionToCheck: Vector2) -> bool:
	return true
	
func CreateSystem(scenePath: String) -> Node2D:
	var instance = load(scenePath).instantiate()
	instance.globalId = globalSystemIdCounter
	globalSystemIdCounter += 1
	return instance

func GetSystemFromId(id: int) -> Node2D:
	for child in get_children():
		if child.globalId == id:
			return child
	
	return null
	
func CreateFromSave(variablesToSet: Dictionary) -> void:
	var instance
	match variablesToSet["systemType"]:
		"thruster":
			instance = CreateSystem("res://Systems/Thruster/thruster.tscn")
			instance.AssignDirection(variablesToSet["assignedAngle"])
		"starmap":
			instance = CreateSystem("res://Systems/Starmap/starmap.tscn")
		"gun":
			instance = CreateSystem("res://Systems/Gun/gun.tscn")
		"controlseat":
			instance = CreateSystem("res://Systems/ControlSeat/controlSeat.tscn")
		"flightcontrol":
			instance = CreateSystem("res://Systems/FlightControl/flightControl.tscn")
			
	globalSystemIdCounter -= 1

	var globalIdToGet = variablesToSet["globalId"]
	instance.globalId = globalIdToGet
	if globalSystemIdCounter <= globalIdToGet:
		globalSystemIdCounter = globalIdToGet + 1
		
	var positionToGet = Vector2(variablesToSet["position.x"], variablesToSet["position.y"])
	var rotationToGet = variablesToSet["rotation"]
	
	AddSystemAtPosition(instance, positionToGet, rotationToGet)

func AddSystemAtPosition(system, positionToGet, rotationToGet) -> void:
	add_child(system)
	system.position = positionToGet
	system.rotation = rotationToGet
	
	if system is Thruster:
		$"..".assignedThrusters.append(system)
