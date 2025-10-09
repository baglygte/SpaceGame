class_name EnterExitArea
extends Area2D

var listenerInControl: PlayerInputListener
	
func ToggleControl(listener: PlayerInputListener) -> void:
	if listenerInControl == listener:
		ReleaseControl()
		return
	
	if listenerInControl == null:
		TakeControl(listener)
		return
	
func ReleaseControl() -> void:
	if listenerInControl == null:
		return
	listenerInControl.SetDefaultInputs()
	var player = listenerInControl.get_parent()
	listenerInControl = null
	
	if get_parent().has_method("OnEnterExit"):
		get_parent().OnEnterExit(player)

func TakeControl(listener: PlayerInputListener):
	listenerInControl = listener
	listener.ClearAllSignals()
	
	listener.moveSignal.connect($"../SignalEmitter".SendMoveSignal)
	listener.lookSignal.connect($"../SignalEmitter".SendLookSignal)
	
	
	if get_parent().has_method("OnEnterExit"):
		get_parent().OnEnterExit(listener.get_parent())
	if get_parent().has_method("OnRightHand"):
		listener.interactRight.connect(get_parent().OnRightHand)
	else:
		listener.interactRight.connect($"../SignalEmitter".SendRightHandSignal)
	if get_parent().has_method("OnLeftHand"):
		listener.interactLeft.connect(get_parent().OnLeftHand)
	else:
		listener.interactLeftPressed.connect($"../SignalEmitter".SendLeftHandSignal)
