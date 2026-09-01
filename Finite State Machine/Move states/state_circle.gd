class_name StateCircle
extends MoveState

var ship: Ship
var deltaToShip: Vector2

func Enter():
	ship = get_tree().get_first_node_in_group("Ship")
	
	deltaToShip = ship.global_position - stateExecutor.global_position
	var rotatedTarget = deltaToShip.rotated(PI/6).normalized()
	var moveTarget =  rotatedTarget * 4000 + stateExecutor.global_position
	
	stateExecutor.target = moveTarget
	
func Update(_delta: float):
	var targetDelta = stateExecutor.target - stateExecutor.global_position

	if targetDelta.length() < 3000:
		transitionToState.emit("StateIdle")
		
	if deltaToShip.length() > 5000:
		transitionToState.emit("StateApproach")
		
	if deltaToShip.length() < 1000:
		transitionToState.emit("StateRetreat")

func Exit():
	return
