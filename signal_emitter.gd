class_name SignalEmitter
extends Node2D

var signalReceivers: Array

func AddReceiver(reciever) -> void:
	signalReceivers.append(reciever)
	
func SendMoveSignal(vector: Vector2) -> void:
	if signalReceivers.size() < 1:
		return
		
	for receiver in signalReceivers:
		if receiver is SignalEmitter:
			continue
		receiver.ReceiveMovement(vector)

func SendLookSignal(vector: Vector2) -> void:
	if signalReceivers.size() < 1:
		return
		
	for receiver in signalReceivers:
		if receiver is SignalEmitter:
			continue
		receiver.ReceiveLook(vector)

func SendLeftHandSignal() -> void:
	if signalReceivers.size() < 1:
		return
		
	for receiver in signalReceivers:
		receiver.ReceiveLeftHand()
		
func SendRightHandSignal() -> void:
	if signalReceivers.size() < 1:
		return
		
	for receiver in signalReceivers:
		receiver.ReceiveRightHand()
		
func SendEnterExit(player: Player) -> void:
	if signalReceivers.size() < 1:
		return
		
	for receiver in signalReceivers:
		receiver.ReceiveEnterExit(player)
