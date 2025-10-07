class_name StateCircle
extends State

@export var enemy : Node2D
var ship: Ship

func Enter():
	ship = get_tree().get_first_node_in_group("Ship")
	
func Update():
	var deltaPosition = ship.global_position - enemy.global_position
	
	enemy.apply_central_force(deltaPosition.normalized().rotated(PI/2) * 500)
	
