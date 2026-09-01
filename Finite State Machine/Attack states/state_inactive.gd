class_name StateInactive
extends AttackState

@export var stateChangeDistance: float = 20000
@export var CloseState: String = "StateShoot"

var ship: Ship


func Enter():
	ship = get_tree().get_first_node_in_group("Ship")
	
func Update(_delta):
	var deltaPosition = stateExecutor.global_position - ship.global_position
	
	if deltaPosition.length() < stateChangeDistance:
		transitionToState.emit(CloseState)

func Exit():
	return
