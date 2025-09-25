class_name SignalEmitter
extends Node2D

var signalReceivers: Array

func AddReceiver(reciever) -> void:
	signalReceivers.append(reciever)
	
func SendMovementSignal(vector: Vector2) -> void:
	if signalReceivers.size() < 1:
		return
		
	for receiver in signalReceivers:
		if receiver is SignalEmitter:
			continue
		receiver.ReceiveMovement(vector)
		
func SendLeftHandSignal() -> void:
	if signalReceivers.size() < 1:
		return
		
	for receiver in signalReceivers:
		receiver.ReceiveLeftHand()
