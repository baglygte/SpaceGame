class_name ForceApplicator
extends Node

@onready var body: RigidBody2D = get_parent()

@export var maxForce: float = 500
@export var maxSpeed: float = 500
@export var maxTorque: float = 100

@export var forceP: float = 0.1
@export var forceD: float = 0.01

@export var torqueP: float = 10000
@export var torqueD: float = 100

var deltaAngle = 0
var previousDeltaAngle = 0
var previousDeltaLength = 0

func _process(delta: float):
	if body.target == null:
		return

	RotateToTarget()
	
	MoveTowardsTarget(delta)

func RotateToTarget():
	var deltaPosition = body.target - body.global_position
#
	deltaAngle = Vector2.UP.rotated(body.rotation).angle_to(deltaPosition.normalized())
	
	if abs(deltaAngle) < PI/100:
		return
		
	body.rotate(0.01 * sign(deltaAngle))
		
	#
	#if abs(deltaAngle) < PI/100:
		#return
		#
	#var P = torqueP * deltaAngle
	#
	#var D = torqueD * (deltaAngle - previousDeltaAngle)
	#
	#body.apply_torque(clamp(P + D, -maxTorque, maxTorque))

func MoveTowardsTarget(frameDelta):
	var direction = body.global_position.direction_to(body.target)
	
	var desiredVelocity = direction  * 5000
	
	var change = (desiredVelocity - body.linear_velocity)
	
	body.linear_velocity += change * frameDelta
	
	#var targetDelta  = body.target - body.global_position
	
	#var P = forceP * targetDelta.length()
	
	#var D = forceD * (targetDelta.length() - previousDeltaLength)
	
	#previousDeltaLength = targetDelta.length()

	#var maxDeltaAngleBeforeThrustShutOff = 0.17
	#
	#if abs(deltaAngle) > maxDeltaAngleBeforeThrustShutOff:
		#deltaAngle = maxDeltaAngleBeforeThrustShutOff
	
	#print(deltaAngle)
	
	#var total = clamp(P, -maxForce, maxForce)
	
	#if body.linear_velocity.length() > maxSpeed:
		#total = -total
	
	#body.apply_central_force(Vector2.UP.rotated(body.rotation) * total)
