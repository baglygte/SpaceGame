class_name FiniteStateMachine
extends Node

@export var initialMoveState: MoveState
@export var initialAttackState: AttackState

var currentMoveState: MoveState
var currentAttackState: AttackState

func _ready():
	for child: State in get_children():
		if child is AttackState:
			child.transitionToState.connect(ChangeAttackState)
		elif child is MoveState:
			child.transitionToState.connect(ChangeMoveState)
	
	initialMoveState.Enter()
	currentMoveState = initialMoveState
	
	initialAttackState.Enter()
	currentAttackState = initialAttackState
	
func _process(_delta: float):
	currentMoveState.Update()
	currentAttackState.Update()
	
func ChangeMoveState(stateName: String):
	currentMoveState.Exit()
	
	var newMoveState = get_node(stateName)
	
	newMoveState.Enter()
	
	currentMoveState = newMoveState

func ChangeAttackState(stateName: String):
	currentAttackState.Exit()
	
	var newAttackState = get_node(stateName)
	
	newAttackState.Enter()
	
	currentAttackState = newAttackState
