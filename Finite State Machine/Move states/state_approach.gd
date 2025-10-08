class_name StateApproach
extends MoveState

var ship: Ship

func Enter():
	ship = get_tree().get_first_node_in_group("Ship")
	
func Update():
	var deltaPosition = stateExecutor.global_position - ship.global_position
	
	stateExecutor.target = ship.global_position
	
	if deltaPosition.length() < 5000:
		transitionToState.emit("StateCircle")
	if deltaPosition.length() > 8000:
		transitionToState.emit("StateIdle")

func Exit():
	return
