class_name StateLaunch
extends MoveState

@export var NextState: String = "StateOrient"
@export var timeToTransition: float = 1

func Enter():
	stateExecutor.target = stateExecutor.global_position + Vector2.UP.rotated(stateExecutor.rotation) * 1000
	
func Update(delta: float):
	if timeToTransition > 0:
		timeToTransition = timeToTransition - delta
	else:
		transitionToState.emit(NextState)

func Exit():
	return
