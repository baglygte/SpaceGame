class_name StateOrient
extends MoveState

var deltaToShip: Vector2
var body: RigidBody2D

func Enter():
	body = get_parent().bodyToMove
	
	var ship = get_tree().get_first_node_in_group("Ship")
	
	var delta = ship.global_position - stateExecutor.global_position
	
	stateExecutor.target = stateExecutor.global_position + delta.normalized() * 0.001
	
func Update(_delta: float):
	var deltaPosition = body.target - body.global_position
	
	var deltaAngle = Vector2.UP.rotated(body.rotation).angle_to(deltaPosition.normalized())
	
	if abs(deltaAngle) < PI/100:
		transitionToState.emit("StateAttack")

func Exit():
	return
