class_name StateInactive
extends AttackState

@export var CloseState: String = "StateShoot"
var ship: Ship


func Enter():
	ship = get_tree().get_first_node_in_group("Ship")
	
func Update():
	var deltaPosition = stateExecutor.global_position - ship.global_position
	
	if deltaPosition.length() < 5000:
		transitionToState.emit(CloseState)

func Exit():
	return
