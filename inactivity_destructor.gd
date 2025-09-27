class_name InactivityDestructor
extends Node2D
# Destroys things that are too far from the ship

const distanceThreshold: float = 1000000
func _ready() -> void:
	assert(get_parent().has_method("Kill"))
	$Timer.timeout.connect(Destroy)
	$Timer.start(10)

func Destroy() -> void:
	if GetDistanceToShip() >= distanceThreshold:
		get_parent().Kill()

func GetDistanceToShip() -> float:
	var ship: Ship = get_tree().get_first_node_in_group("Ship")
	var delta: Vector2 = ship.global_position - get_parent().global_position
	return delta.length()
