class_name Thruster
extends Node2D

var globalId: int
const strength := 50
var isContributing: bool = false

func _process(_delta: float) -> void:
	$GPUParticles2D.emitting = false
	
func GetThrustContribution(flightControl: FlightControl, movementVector: Vector2) -> Vector2:
	var contribution = Vector2.UP.rotated(rotation)
	var rotatedMovement = movementVector.rotated(flightControl.rotation)
	
	contribution = round(contribution)
	
	if sign(rotatedMovement.x) != sign(contribution.x):
		contribution.x = 0
	
	if sign(rotatedMovement.y) != sign(contribution.y):
		contribution.y = 0

	if contribution.length() > 0:
		$GPUParticles2D.emitting = true

	return contribution * strength

func GetSaveData() -> Dictionary:
	var dictionaryToSave: Dictionary = {"creator": "ExternalSystemBuilder"}
	
	dictionaryToSave["systemType"] = "thruster"
	dictionaryToSave["position.x"] = position.x
	dictionaryToSave["position.y"] = position.y
	dictionaryToSave["rotation"] = rotation
	dictionaryToSave["globalId"] = globalId

	return dictionaryToSave
