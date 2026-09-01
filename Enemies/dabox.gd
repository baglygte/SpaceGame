extends RigidBody2D

var canShoot := false
var target
const rocketScene = preload("res://Rockets/homing_rocket.tscn")

func _ready() -> void:
	$Timer.timeout.connect(Reload)
	$Timer.start(1)
	
	$StarmapBlipConnector.Initialize("EnemyShip")

func Reload():
	canShoot = true
	
func ShootRocket() -> void:
	var ship = get_tree().get_first_node_in_group("Ship")
	
	#var shipDirection: Vector2 = (ship.position - position).normalized()
	
	var rocket: HomingRocket = rocketScene.instantiate()
	
	rocket.lockedOnNode = ship

	rocket.global_position = $RocketLaunchPosition.global_position
	
	var skrt = Vector2.UP.angle_to($RocketLaunchPosition.position)
	
	rocket.rotation = skrt
	
	get_parent().add_child(rocket)
	
	canShoot = false
	#$Timer.start(1)

func Kill() -> void:
	$StarmapBlipConnector.Kill()
	queue_free()
