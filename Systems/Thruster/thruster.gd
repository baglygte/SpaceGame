class_name Thruster
extends Node2D

var globalId: int
var assignedDirection := Vector2.ZERO
var assignedAngle: float
const strength := 500
const directionTextMap := {Vector2.UP: "Up",
							Vector2.DOWN: "Down",
							Vector2.RIGHT: "Right",
							Vector2.LEFT: "Left"}

func ReceiveMovement(movementVector: Vector2) -> void:
	if movementVector.length() == 0:
		return
		
	AssignDirection(rad_to_deg(movementVector.angle()))

func AssignDirection(angle: float) -> void:
	var directionToAssign: Vector2
	
	if angle > -135 and angle < -45:
		directionToAssign = Vector2.UP
	elif angle > -45 and angle < 45:
		directionToAssign = Vector2.RIGHT
	elif angle > 45 and angle < 135:
		directionToAssign = Vector2.DOWN
	else:
		directionToAssign = Vector2.LEFT
	
	assignedDirection = directionToAssign * strength
	$Label.text = directionTextMap[directionToAssign]
	assignedAngle = angle
	
func GetSaveData() -> Dictionary:
	var dictionaryToSave: Dictionary = {"creator": "SystemBuilder"}
	
	dictionaryToSave["systemType"] = "thruster"
	dictionaryToSave["position.x"] = position.x
	dictionaryToSave["position.y"] = position.y
	dictionaryToSave["rotation"] = rotation
	dictionaryToSave["globalId"] = globalId
	dictionaryToSave["assignedAngle"] = assignedAngle
	
	return dictionaryToSave
