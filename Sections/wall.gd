class_name Wall
extends Node2D

func _ready() -> void:
	$Health.maxHealth = 4
	$Health.GainHealth(4)
