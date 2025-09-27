class_name Rocket
extends RigidBody2D

func _ready() -> void:
	max_contacts_reported = 1
	contact_monitor = true
	
	$Health.maxHealth = 1
	$Health.GainHealth(1)
	
	apply_central_force(Vector2.UP.rotated(rotation) * 10000)

func _process(_delta: float) -> void:
	var bodies = get_colliding_bodies()
	
	if bodies.size() < 1:
		return
		
	for body in bodies:
		if body is Rocket:
			body.get_node("Health").LoseHealth(1)
		else:
			body.get_parent().get_node("Health").LoseHealth(1)
	
	queue_free()
