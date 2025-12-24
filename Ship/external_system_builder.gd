class_name ExternalSystemBuilder
extends Node

func IsSystemPositionValid(_positionToCheck: Vector2) -> bool:
	return true
	
func CreateExternalSystem(scenePath: String) -> Node2D:
	var instance = load(scenePath).instantiate()
	instance.globalId = $"../../GlobalSystemCounter".counterValue
	$"../../GlobalSystemCounter".counterValue += 1
	return instance

func GetSystemFromId(id: int, ship: Ship) -> Node2D:
	var system = null
	
	for child in ship.get_children():
		if !child.is_in_group("ExternalSystem"):
			continue
		
		if child.globalId == id:
			system = child
			break
				
	return system
	
func CreateFromSave(variablesToSet: Dictionary, ship: Ship) -> void:
	var instance
	
	match variablesToSet["systemType"]:
		"thruster":
			instance = CreateExternalSystem("res://Systems/Thruster/thruster.tscn")
		"gun":
			instance = CreateExternalSystem("res://Systems/Gun/gun.tscn")
		"grabberArm":
			instance = CreateExternalSystem("res://Systems/GrabberArm/grabber_arm.tscn")
			
	$"../../GlobalSystemCounter".counterValue -= 1

	var globalIdToGet = variablesToSet["globalId"]
	instance.globalId = globalIdToGet
	if $"../../GlobalSystemCounter".counterValue <= globalIdToGet:
		$"../../GlobalSystemCounter".counterValue = globalIdToGet + 1
		
	var positionToGet = Vector2(variablesToSet["position.x"], variablesToSet["position.y"])
	var rotationToGet = variablesToSet["rotation"]
	
	AddSystemAtPosition(instance, positionToGet, rotationToGet, ship)

func AddSystemAtPosition(system, positionToGet, rotationToGet, ship: Ship) -> void:
	if system.get_parent() == null:
		ship.get_node("ExternalSystems").add_child(system)
	else:
		system.reparent(ship.get_node("ExternalSystems"))
	
	system.position = positionToGet
	system.rotation = rotationToGet
	
	if system is Thruster:
		ship.assignedThrusters.append(system)
