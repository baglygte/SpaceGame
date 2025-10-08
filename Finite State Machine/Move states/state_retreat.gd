class_name StateRetreat
extends MoveState

var ship: Ship

func Enter():
	ship = get_tree().get_first_node_in_group("Ship")
	
func Update():
	var deltaPosition = stateExecutor.global_position - ship.global_position
	
	var targetPosition = stateExecutor.global_position + deltaPosition.normalized() * 5000
	
	stateExecutor.target = targetPosition
	
	if deltaPosition.length() > 3000:
		transitionToState.emit("StateIdle")

func Exit():
	return
