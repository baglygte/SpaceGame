class_name StateApproach
extends MoveState
# Move directly towards the ship

@export var CloseState: String = "StateCircle"
@export var FarState: String = "StateIdle"

@export var CloseStateDistance: int = 5000
@export var FarStateDistance: int = 8000

var ship: Ship

func Enter():
	ship = get_tree().get_first_node_in_group("Ship")
	
	stateExecutor.target = ship.global_position
	
func Update(_delta: float):
	var deltaPosition = stateExecutor.global_position - stateExecutor.target

	if deltaPosition.length() < CloseStateDistance:
		transitionToState.emit(CloseState)
	if deltaPosition.length() > FarStateDistance:
		transitionToState.emit(FarState)

func Exit():
	return
