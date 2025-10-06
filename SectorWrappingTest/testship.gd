extends RigidBody2D

func _process(_delta: float) -> void:
	var xMove = Input.get_axis("0_move_left", "0_move_right")
	var yMove = Input.get_axis("0_move_up", "0_move_down")
	var moveVector = Vector2(xMove, yMove)
	
	if moveVector.length() <= 0:
		return
		
	apply_central_force(moveVector * 200)
