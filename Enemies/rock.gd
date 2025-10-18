extends RigidBody2D

var target
var collisionVector: Vector2


func _ready() -> void:
	$Health.maxHealth = 1
	$Health.GainHealth(1)
	
	$StarmapBlipConnector.Initialize("EnemyShip")

func _process(_delta: float) -> void:
	var bodies = get_colliding_bodies()
	
	if bodies.size() < 1:
		return
		
	for body in bodies:
		var healthTarget = null
		if body.has_node("Health"): healthTarget = body.get_node("Health")
		while not body is RigidBody2D:
			body = body.get_parent()
			if body == null: break
			if body.has_node("Health"): healthTarget = body.get_node("Health")
		if body == null: break
		collisionVector = linear_velocity - body.linear_velocity
		if healthTarget != null:
			var a: int = round(mass*collisionVector.length())
			healthTarget.LoseHealth(a)
		body.apply_central_force(mass*collisionVector)
		apply_central_force(-body.mass*collisionVector)


func Kill() -> void:
	$StarmapBlipConnector.Kill()
	queue_free()
