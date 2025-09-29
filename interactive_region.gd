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
	listenerInControl = null

func TakeControl(listener:PlayerInputListener):
	listenerInControl = listener
	listener.ResetInputs()
	
	listener.moveSignal.connect($"../SignalEmitter".SendMoveSignal)
	listener.lookSignal.connect($"../SignalEmitter".SendLookSignal)
	listener.interactLeft.connect($"../SignalEmitter".SendLeftHandSignal)
