class_name ObjectHighlight
extends Control

func SetObjectToHighlight(player: Player, object: Node2D):
	var windowSize = get_viewport_rect().size
	
	var screenCenterPosition = Vector2(windowSize.x / 4, windowSize.y / 2)
	
	var objectToPlayerDelta = player.global_position - object.global_position

	position = round(screenCenterPosition - objectToPlayerDelta)
	
	print(position)
