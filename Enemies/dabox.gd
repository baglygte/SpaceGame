extends Node2D

const rocketScene = preload("res://Rockets/homing_rocket.tscn")

func _ready() -> void:
	$Timer.timeout.connect(SpawnRocket)
	$Timer.start(1)
	
	$Health.maxHealth = 1
	$Health.GainHealth(1)
	
	$StarmapBlipConnector.Initialize("EnemyShip")
	
func SpawnRocket() -> void:
	var ship = get_tree().get_first_node_in_group("Ship")
	var angle = position.angle_to_point(ship.position)
	
	var rocket = rocketScene.instantiate()
	rocket.rotation = angle
	rocket.position = position + $SpawnPosition.position
	get_parent().add_child(rocket)
	$Timer.start(20)

func Kill() -> void:
	$StarmapBlipConnector.Kill()
	queue_free()
