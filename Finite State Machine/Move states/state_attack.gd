class_name StateAttack
extends MoveState

func Enter():
	var ship = get_tree().get_first_node_in_group("Ship")
	
	stateExecutor.target = ship.global_position
	
func Update(_delta: float):
	return

func Exit():
	return
