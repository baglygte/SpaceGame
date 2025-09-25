extends Node2D

#var availableThrust: Vector4

func ReceiveMovement(movementVector: Vector2) -> void:
	var ship: Ship = get_tree().get_first_node_in_group("Ship")
	
	var availableThrust: Vector4
	
	if movementVector.length() == 0:
		return
	
	for thruster: Thruster in ship.assignedThrusters:
		var thrusterVector = thruster.assignedDirection
		
		if thrusterVector == null:
			continue
			
		var xThrust = thrusterVector.x
		
		if xThrust > 0:
			availableThrust.w += xThrust
		elif xThrust < 0:
			availableThrust.x -= xThrust
			
		var yThrust = thrusterVector.y
		
		if yThrust > 0:
			availableThrust.y += yThrust
		elif yThrust < 0:
			availableThrust.z -= yThrust
	
	var totalVector: Vector2
	if movementVector.x > 0:
		totalVector.x = movementVector.x * availableThrust.w
	if movementVector.x < 0:
		totalVector.x = movementVector.x * availableThrust.x
	if movementVector.y > 0:
		totalVector.y = movementVector.y * availableThrust.y
	if movementVector.y < 0:
		totalVector.y = movementVector.y * availableThrust.z
		
	ship.ApplyThrust(totalVector)

func GetSaveData() -> Dictionary:
	var dictionaryToSave: Dictionary = {"creator": "ShipSectionBuilder"}
	
	dictionaryToSave["systemType"] = "flightcontrol"
	dictionaryToSave["position.x"] = position.x
	dictionaryToSave["position.y"] = position.y
	
	return dictionaryToSave
