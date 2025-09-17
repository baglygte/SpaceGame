extends Node
# Listens for inputs and emits corresponding signals
class_name InputManager

signal moveSignal
signal interactSignal
signal leftClickSignal
signal modifySignal

func _process(_delta: float) -> void:
	var moveInputVector = Input.get_vector("left", "right", "up", "down")
	moveSignal.emit(moveInputVector)
	
	if Input.is_action_just_pressed("interact"):
		interactSignal.emit()
		
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		leftClickSignal.emit()
		
	if Input.is_action_just_pressed("modify"):
		modifySignal.emit()

func ClearSignal(signalToClear) -> void:
	for connection in signalToClear.get_connections():
		signalToClear.disconnect(connection.callable)
		
