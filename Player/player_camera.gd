extends Camera2D

var connectedPlayer: Player
var isZoomedOut: bool = false
func _process(_delta: float) -> void:
	if connectedPlayer == null:
		return
	global_position = connectedPlayer.global_position

func ToggleZoom() -> void:
	if isZoomedOut:
		isZoomedOut = false
		zoom = Vector2.ONE * 2
	else:
		isZoomedOut = true
		zoom = Vector2.ONE
