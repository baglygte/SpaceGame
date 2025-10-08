class_name StateIdle
extends MoveState

var ship: Ship

func Enter():
	ship = get_tree().get_first_node_in_group("Ship")
	
func Update():
	var deltaPosition = ship.global_position - stateExecutor.global_position

	if deltaPosition.length() < 7000:
		transitionToState.emit("StateApproach")

func Exit():
	return
