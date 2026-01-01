# Can send a signal (stemming from player input) to an array of connected
# signal receivers
class_name SignalEmitter
extends Node2D

var signalReceivers: Array[SignalReceiver]

func RemoveReciever(receiver: SignalReceiver):
	var recieverIndex = signalReceivers.find(receiver)
	signalReceivers.remove_at(recieverIndex)
	
func AddReceiver(reciever: SignalReceiver):
	signalReceivers.append(reciever)
	
func SendMoveSignal(vector: Vector2) -> void:
	if signalReceivers.size() < 1:
		return
		
	for receiver in signalReceivers:
		receiver.ReceiveMovement(vector)

func SendLookSignal(vector: Vector2) -> void:
	if signalReceivers.size() < 1:
		return
		
	for receiver in signalReceivers:
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
