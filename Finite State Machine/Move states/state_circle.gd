class_name StateCircle
extends MoveState

var ship: Ship

func Enter():
	ship = get_tree().get_first_node_in_group("Ship")
	
func Update():
	var deltaPosition = ship.global_position - stateExecutor.global_position
	var rotatedTarget = deltaPosition.rotated(PI/6).normalized()
	var moveTarget =  rotatedTarget * 4000 + stateExecutor.global_position
	
	stateExecutor.target = moveTarget
	
	if deltaPosition.length() > 5000:
		transitionToState.emit("StateApproach")
	if deltaPosition.length() < 1000:
		transitionToState.emit("StateRetreat")

func Exit():
	return
