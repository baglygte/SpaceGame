class_name InactivityDestructor
extends Node2D
# Destroys things that are too far from the ship

const distanceThreshold: float = 10000

func _ready() -> void:
	assert(get_parent().has_method("Kill"))
	$Timer.timeout.connect(Kill)
	$Timer.start(10)

func Kill() -> void:
	if GetDistanceToShip() >= distanceThreshold:
		get_parent().Kill()
	$Timer.start(10)

func GetDistanceToShip() -> float:
	var ship: Ship = get_tree().get_first_node_in_group("Ship")
	var delta: Vector2 = ship.global_position - get_parent().global_position
	return delta.length()
