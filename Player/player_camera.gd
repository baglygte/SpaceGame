extends Camera2D

var connectedPlayer: Player
@onready var targetZoomLevel: float = zoomedInZoomLevel

const zoomedInZoomLevel: float = 1.5
const zoomedOutZoomLevel: float = 0.1
const zoomSpeed: float = 0.1

func _process(_delta: float) -> void:
	if connectedPlayer == null:
		return
		
	global_position = connectedPlayer.global_position
	rotation = get_tree().get_first_node_in_group("Ship").rotation
	
	Zoom()

func ToggleZoom() -> void:
	if targetZoomLevel == zoomedInZoomLevel:
		targetZoomLevel = zoomedOutZoomLevel
	else:
		targetZoomLevel = zoomedInZoomLevel

func Zoom() -> void:
	var delta = round(abs(zoom.x - targetZoomLevel)*100)/100
	
	if delta == 0:
		return
	
	if zoom.x < targetZoomLevel:
		zoom += Vector2.ONE * zoomSpeed * delta
	else:
		zoom -= Vector2.ONE * zoomSpeed * delta
