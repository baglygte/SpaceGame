extends Camera2D

var targetZoom := Vector2(2,2)
const zoomSpeed = 25

func ChangeZoom() -> void:
	
	if targetZoom == Vector2(2,2):
		targetZoom = Vector2(0.5, 0.5)
	else:
		targetZoom = Vector2(2,2)
	
func _process(delta: float) -> void:
	if zoom == targetZoom:
		pass

	var zoomValue = lerp(zoom.x, targetZoom.x, delta * zoomSpeed)
	zoom = Vector2(zoomValue, zoomValue)
