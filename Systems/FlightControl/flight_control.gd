class_name FlightControl
extends Node2D

var globalId: int
var ship: Ship

func _ready() -> void:
	ship = get_tree().get_first_node_in_group("Ship")

func ReceiveMovement(movementVector: Vector2) -> void:
	if movementVector.length() == 0:
		return
	
	for thruster: Thruster in ship.assignedThrusters:
		var forceToApply = thruster.GetThrustMoveContribution(self, movementVector)
		ship.apply_force(forceToApply, thruster.position)

func ReceiveLook(lookVector: Vector2) -> void:
	if lookVector.length() == 0:
		return
		
	for thruster: Thruster in ship.assignedThrusters:
		var forceToApply = thruster.GetThrustLookContribution(lookVector.x, ship)
		ship.apply_force(forceToApply, thruster.position)
	
func GetSaveData() -> Dictionary:
	var dictionaryToSave: Dictionary = {"creator": "InternalSystemBuilder"}
	
	dictionaryToSave["systemType"] = "flightcontrol"
	dictionaryToSave["position.x"] = global_position.x
	dictionaryToSave["position.y"] = global_position.y
	dictionaryToSave["rotation"] = rotation
	dictionaryToSave["globalId"] = globalId
	
	return dictionaryToSave
