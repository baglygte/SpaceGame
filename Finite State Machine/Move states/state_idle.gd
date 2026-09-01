class_name StateIdle
extends MoveState

@export var stateChangeDistance: float = 20000

var ship: Ship

func Enter():
	ship = get_tree().get_first_node_in_group("Ship")
	
	stateExecutor.target = ship.global_position
	
func Update(_delta: float):
	var deltaPosition = stateExecutor.target - stateExecutor.global_position

	if deltaPosition.length() < stateChangeDistance:
		transitionToState.emit("StateApproach")

func Exit():
	return
