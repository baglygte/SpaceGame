class_name Thruster
extends Node2D

var assignedDirection: Vector2
const strength := 500

func ReceiveMovement(movementVector: Vector2) -> void:
	if movementVector.length() == 0:
		return
		
	var angle = rad_to_deg(movementVector.angle())
	if angle > -135 and angle < -45:
		assignedDirection = Vector2.UP * strength
		$Label.text = "Up"
	elif angle > -45 and angle < 45:
		assignedDirection = Vector2.RIGHT * strength
		$Label.text = "Right"
	elif angle > 45 and angle < 135:
		assignedDirection = Vector2.DOWN * strength
		$Label.text = "Down"
	else:
		assignedDirection = Vector2.LEFT * strength
		$Label.text = "Left"

func GetSaveData() -> Dictionary:
	var dictionaryToSave: Dictionary = {"creator": "ShipSectionBuilder"}
	
	dictionaryToSave["systemType"] = "thruster"
	dictionaryToSave["position.x"] = position.x
	dictionaryToSave["position.y"] = position.y
	dictionaryToSave["rotation"] = rotation
	
	return dictionaryToSave
