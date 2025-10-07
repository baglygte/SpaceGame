class_name StateIdle
extends State

@export var enemy : Node2D
var ship: Ship

func Enter():
	ship = get_tree().get_first_node_in_group("Ship")
	
func Update():
	var deltaPosition = ship.global_position - enemy.global_position
	
	if deltaPosition.length() < 2000:
		transitioned.emit("StateCircle")
