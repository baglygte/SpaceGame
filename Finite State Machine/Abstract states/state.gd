@abstract
class_name State
extends Node

@onready var stateExecutor = get_parent().get_parent()
signal transitionToState

@abstract func Enter()
	
@abstract func Exit()
	
@abstract func Update()
