class_name Wall
extends Node2D
	
func Kill() -> void:
	queue_free()
