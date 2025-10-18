class_name StateRam
extends MoveState

@export var FarState: String = "StateApproach"
@export var CloseState: String = "StateRetreat"

var ship: Ship

func Enter():
	ship = get_tree().get_first_node_in_group("Ship")
	
	
func Update():
	var deltaPosition = stateExecutor.global_position - ship.global_position
	var deltaVelocity = stateExecutor.linear_velocity - ship.linear_velocity
	
	stateExecutor.target = ship.global_position
	
	if deltaPosition.length() > 5000:
		transitionToState.emit(FarState)
	if deltaPosition.length() < 1000 and deltaVelocity.length() < 100:
		transitionToState.emit(CloseState)

func Exit():
	return
