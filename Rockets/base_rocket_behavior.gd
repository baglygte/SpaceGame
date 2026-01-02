extends Node2D

var parent: RigidBody2D

func _ready() -> void:
	parent = get_parent()
	
	parent.max_contacts_reported = 1
	parent.contact_monitor = true

func _process(_delta: float) -> void:
	var bodies = parent.get_colliding_bodies()
	
	if bodies.size() < 1:
		return
		
	for body in bodies:
		if body.has_node("BaseRocketBehavior"):
			continue
		
		if body is RigidBody2D:
			body.get_node("Health").LoseHealth(1)
		else:
			body.get_parent().get_node("Health").LoseHealth(1)
		
		
	parent.get_node("Health").LoseHealth(1)
