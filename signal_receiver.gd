class_name SignalReceiver
extends Node2D

func ReceiveMovement(vector: Vector2) -> void:
	get_parent().ReceiveMovement(vector)
