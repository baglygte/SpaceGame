extends RigidBody2D

var ship: Ship
var lockedOnNode: Node2D
var target: Vector2

func _ready() -> void:
	ship = get_tree().get_first_node_in_group("Ship")
	apply_central_force(Vector2.UP.rotated(rotation) * 10000)
	
	$StarmapBlipConnector.Initialize("EnemyRocket")

func _process(_delta: float) -> void:
	target = lockedOnNode.global_position
	
func Kill() -> void:
	$StarmapBlipConnector.Kill()
	
	queue_free()
