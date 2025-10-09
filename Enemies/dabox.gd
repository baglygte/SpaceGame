extends RigidBody2D

var canShoot := false
var target
const rocketScene = preload("res://Rockets/homing_rocket.tscn")

func _ready() -> void:
	$Timer.timeout.connect(Reload)
	$Timer.start(1)
	$Health.maxHealth = 1
	$Health.GainHealth(1)
	
	$StarmapBlipConnector.Initialize("EnemyShip")

func Reload():
	canShoot = true
	
func ShootRocket() -> void:
	var ship = get_tree().get_first_node_in_group("Ship")
	var shipDirection: Vector2 = (ship.position - position).normalized()
	
	var rocket = rocketScene.instantiate()
	rocket.rotation = shipDirection.angle()
	rocket.position = position + shipDirection * 500
	get_parent().add_child(rocket)
	
	canShoot = false
	$Timer.start(10)

func Kill() -> void:
	$StarmapBlipConnector.Kill()
	queue_free()
