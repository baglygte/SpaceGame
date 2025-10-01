extends RigidBody2D

func _ready() -> void:
	$Health.maxHealth = 1
	$Health.GainHealth(1)
	
	$StarmapBlipConnector.blipType = "EnemyRocket"
	$StarmapBlipConnector.Initialize()

func _process(_delta: float) -> void:
	apply_central_force(Vector2.UP.rotated(rotation) * 100)
	
func Kill() -> void:
	$StarmapBlipConnector.Kill()
	queue_free()
