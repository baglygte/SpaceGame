extends RigidBody2D

var ship: Ship
func _ready() -> void:
	ship = get_tree().get_first_node_in_group("Ship")
	apply_central_force(Vector2.UP.rotated(rotation) * 10000)
	
	$StarmapBlipConnector.Initialize("EnemyRocket")
	
func _process(_delta: float) -> void:
	var vectorPointingToShip: Vector2 = ship.position - position
	vectorPointingToShip = vectorPointingToShip.normalized()
	apply_force(vectorPointingToShip * 100, Vector2(0,15))

func Kill() -> void:
	$StarmapBlipConnector.Kill()
	queue_free()
