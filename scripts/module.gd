extends Node2D
class_name Module

const moduleWidth = 64.0

func GetType() -> Node2D:
	return get_child(1)

func RotateByDegrees(angle) -> void:
	rotate(deg_to_rad(angle))
