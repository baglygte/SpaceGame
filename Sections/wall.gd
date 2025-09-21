extends Node2D

func RotateToLeft() -> void:
	rotate(deg_to_rad(0))
	
func RotateToUp() -> void:
	rotate(deg_to_rad(90))
	
func RotateToRight() -> void:
	rotate(deg_to_rad(180))
	
func RotateToDown() -> void:
	rotate(deg_to_rad(270))
