extends Control

#func _process(_delta: float) -> void:
	#var ship = get_tree().get_first_node_in_group("Ship")
	#
	#if ship == null:
		#return
	#
	#var xText = "x: " + str(round(ship.position.x / 100))
	#var yText = "y: " + str(round(ship.position.y / 100))
	#
	#$CenterContainer/HBoxContainer/VBoxContainer/xCoorLabel.text = xText
	#$CenterContainer/HBoxContainer/VBoxContainer/yCoorLabel.text = yText
	#
	#$CenterContainer/HBoxContainer/Control/Sprite2D.rotation = ship.rotation
