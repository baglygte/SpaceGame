extends RigidBody2D

func _ready() -> void:
	$Health.maxHealth = 1
	$Health.GainHealth(1)
	
	$StarmapBlipConnector.blipType = "EnemyRocket"
	$StarmapBlipConnector.Initialize()

func _process(_delta: float) -> void:
	if linear_velocity.length() > 10000:
		return
	apply_central_force(Vector2.UP.rotated(rotation) * 5000)
	
func Kill() -> void:
	$StarmapBlipConnector.Kill()
	queue_free()
