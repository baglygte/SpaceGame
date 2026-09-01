class_name StateShooting
extends AttackState

@export var stateChangeDistance: float = 20000
var ship: Ship

func Enter():
	ship = get_tree().get_first_node_in_group("Ship")
	
	stateExecutor.target = ship.global_position
	
func Update(_delta):
	var deltaPosition = stateExecutor.global_position - stateExecutor.target
	
	if deltaPosition.length() > stateChangeDistance:
		transitionToState.emit("StateInactive")
		return
	
	if stateExecutor.canShoot:
		stateExecutor.ShootRocket()

func Exit():
	return
