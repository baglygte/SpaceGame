extends RigidBody2D
class_name HomingRocket
var ship: Ship
var lockedOnNode: Node2D
var target: Vector2

func _ready() -> void:
	ship = get_tree().get_first_node_in_group("Ship")
	
	apply_central_force(Vector2.UP.rotated(rotation) * 5000)
	
	$StarmapBlipConnector.Initialize("EnemyRocket")
	
func Kill() -> void:
	$StarmapBlipConnector.Kill()
	var soundSystem: SoundSystem = get_tree().get_first_node_in_group("SoundSystem")
	soundSystem.PlaySoundAtPosition("res://Audio/explosionA.ogg", global_position)
	queue_free()
