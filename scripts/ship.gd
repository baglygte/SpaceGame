extends RigidBody2D
# The physical representation of the ship.
# Contains everything the player can interacted with
# Modules, walls, etc.
class_name Ship
@onready var shipBuilder: ShipBuilder = $ShipBuilder

var moveDirection := Vector2(0,0)
var player: Player
var assignedThrusters: Array

func _physics_process(_delta: float) -> void:
	apply_central_force(moveDirection * 200)

func AddPlayer(playerToAdd: Player) -> void:
	add_child(playerToAdd)
	player = playerToAdd

func AddThruster(thrusterObject) -> void:
	add_child(thrusterObject)
	assignedThrusters.append(thrusterObject)

func ApplyThrust(inputs) -> void:
	if inputs == Vector2.ZERO:
		return;
		
	for module in assignedThrusters:
		var thruster = module.GetType()
		
		if !thruster.IsAssignedKey(inputs):
			continue
			
		apply_force(thruster.GetForceToApply(), module.global_position * 200)
