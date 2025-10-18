class_name StateApproach
extends MoveState

@export var CloseState: String = "StateCircle"
@export var FarState: String = "StateIdle"

var ship: Ship

func Enter():
	ship = get_tree().get_first_node_in_group("Ship")
	
func Update():
	var deltaPosition = stateExecutor.global_position - ship.global_position
	
	stateExecutor.target = ship.global_position
	
	if deltaPosition.length() < 5000:
		transitionToState.emit(CloseState)
	if deltaPosition.length() > 8000:
		transitionToState.emit(FarState)

func Exit():
	return
