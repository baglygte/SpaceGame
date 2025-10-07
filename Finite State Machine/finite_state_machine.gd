class_name FiniteStateMachine
extends Node

@export var initialState: State
var currentState: State
var states: Dictionary = {}

func _ready():
	for child in get_children():
		if not child is State:
			continue
		states[child.name] = child
		child.transitioned.connect(ChangeState)
	
	if initialState == null:
		return
	
	initialState.Enter()
	currentState = initialState
	
func _process(_delta: float):
	if currentState == null:
		return
		
	currentState.Update()
	
func ChangeState(stateName: String):
	if not stateName in states.keys():
		return
	
	if currentState != null:
		currentState.Exit()
	
	var newState: State = states[stateName]
	newState.Enter()
	
	currentState = newState
