extends RigidBody2D
# The physical representation of the ship.
# Contains everything the player can interacted with
# Modules, walls, etc.
class_name Ship

var moveDirection := Vector2(0,0)
var player: Player
var assignedThrusters: Array

func _physics_process(_delta: float) -> void:
	apply_central_force(moveDirection * 200)

func AddPlayer(playerToAdd: Player) -> void:
	add_child(playerToAdd)
	player = playerToAdd

func AddSection(section: Node2D) -> void:
	add_child(section)
		
func RemoveSection(section: Node2D) -> void:
	remove_child(section)
	
func ApplyThrust(inputs) -> void:
	if inputs == Vector2.ZERO:
		return
		
	#apply_central_force(inputs)
