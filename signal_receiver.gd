class_name SignalReceiver
extends Node2D

func ReceiveMovement(vector: Vector2) -> void:
	if not get_parent().has_method("ReceiveMovement"):
		return
		
	get_parent().ReceiveMovement(vector)
	
func ReceiveLook(vector: Vector2) -> void:
	if not get_parent().has_method("ReceiveLook"):
		return
		
	get_parent().ReceiveLook(vector)
	
func ReceiveLeftHand() -> void:
	if not get_parent().has_method("ReceiveLeftHand"):
		return
		
	get_parent().ReceiveLeftHand()
	
func ReceiveRightHand() -> void:
	if not get_parent().has_method("ReceiveRightHand"):
		return
		
	get_parent().ReceiveRightHand()

func ReceiveEnterExit(player: Player) -> void:
	if get_parent().has_method("ReceiveEnterExit"):
		get_parent().ReceiveEnterExit(player)
