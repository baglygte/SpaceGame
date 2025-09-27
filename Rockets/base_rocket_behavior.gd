extends Node2D

var parent: RigidBody2D

func _ready() -> void:
	assert(get_parent() is RigidBody2D)
	parent = get_parent()
	
	parent.max_contacts_reported = 1
	parent.contact_monitor = true
	

func _process(_delta: float) -> void:
	var bodies = parent.get_colliding_bodies()
	
	if bodies.size() < 1:
		return
		
	for body in bodies:
		if not body.has_node("BaseRocketBehavior"):
			body.get_parent().get_node("Health").LoseHealth(1)
		
	parent.get_node("Health").LoseHealth(1)
