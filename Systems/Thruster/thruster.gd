class_name Thruster
extends Node2D

var globalId: int
const strength := 50
var isContributing: bool = false

func _process(_delta: float) -> void:
	$GPUParticles2D.emitting = false
	
func GetThrustMoveContribution(flightControl: FlightControl, movementVector: Vector2) -> Vector2:
	var contribution = Vector2.UP.rotated(rotation)
	var rotatedMovement = movementVector.rotated(flightControl.rotation)
	
	contribution = round(contribution) * abs(movementVector)
	
	if sign(rotatedMovement.x) != sign(contribution.x):
		contribution.x = 0
	
	if sign(rotatedMovement.y) != sign(contribution.y):
		contribution.y = 0

	if contribution.length() > 0:
		$GPUParticles2D.emitting = true

	return contribution * strength

func GetThrustLookContribution(lookMagnitude: float, ship: Ship) -> Vector2:
	var contribution = round(Vector2.UP.rotated(rotation))
	
	var delta
	
	if contribution.x == 0:
		delta = ship.center_of_mass.x - position.x
		
		if delta == 0:
			return Vector2.ZERO

		if sign(delta * lookMagnitude) != sign(contribution.y):
			return Vector2.ZERO
		
		contribution.y = -contribution.y
		
	if contribution.y == 0:
		delta = ship.center_of_mass.y - position.y
		
		if delta == 0:
			return Vector2.ZERO
		
		if sign(delta * lookMagnitude) != sign(contribution.x):
			return Vector2.ZERO
		
	$GPUParticles2D.emitting = true
	return contribution * strength * abs(lookMagnitude) * strength

func GetSaveData() -> Dictionary:
	var dictionaryToSave: Dictionary
	
	dictionaryToSave["systemType"] = "thruster"
	dictionaryToSave["position.x"] = position.x
	dictionaryToSave["position.y"] = position.y
	dictionaryToSave["rotation"] = rotation
	dictionaryToSave["globalId"] = globalId

	return dictionaryToSave
