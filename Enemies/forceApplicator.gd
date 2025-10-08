class_name ForceApplicator
extends Node

@onready var body: RigidBody2D = get_parent()

@export var maxSpeed: float = 500
@export var torque: float = 100
@export var forceMultiplier: float = 1

func _process(_delta: float):
	if body.target == null:
		return
		
	RotateToTarget()
	
	MoveTowardsTarget()
	
func RotateToTarget():
	var deltaPosition = body.target - body.global_position
	var angleBetween = GetForwardDirection().angle_to(deltaPosition.normalized())
	
	if abs(angleBetween) < PI/100:
		return
	
	body.apply_torque(angleBetween * torque)

func MoveTowardsTarget():
	var currentSpeed = body.linear_velocity.length()
	
	if  currentSpeed > maxSpeed:
		return

	var currentDirection = body.linear_velocity.normalized()
	var directionToTarget = (body.target - body.global_position).normalized()
	var correctionForceDirection = directionToTarget - currentDirection
	var forceMagnitude = (body.linear_velocity - directionToTarget * forceMultiplier).length()
	var forceToApply = (GetForwardDirection() + correctionForceDirection) * forceMagnitude

	body.apply_central_force(forceToApply)

func GetForwardDirection() -> Vector2:
	return Vector2.UP.rotated(body.rotation)
