extends Camera2D

const closestZoom = 1.5
const fartherstZoom = 1
const windowSize = Vector2(1280, 720)
const windowMargin = 100

var targetZoom = 1
	
func _process(_delta: float) -> void:
	global_position = GetAveragePositionOfAllPlayers()
	AssignZoom()

func AssignZoom() -> void:
	var players: Array = get_tree().get_nodes_in_group("Player")
	
	var minX = INF
	var maxX = -INF
	var minY = INF
	var maxY = -INF
	
	for player in players:
		var playerXPos = player.global_position.x
		var playerYPos = player.global_position.y
		
		if playerXPos > maxX:
			maxX = playerXPos
		if playerXPos < minX:
			minX = playerXPos
		if playerYPos > maxY:
			maxY = playerYPos
		if playerYPos < minY:
			minY = playerYPos
	
	var deltaX = maxX - minX
	var deltaY = maxY - minY
	
	var zoomX = windowSize.x / (deltaX + windowMargin)
	var zoomY = windowSize.y / (deltaY + windowMargin)
	
	targetZoom = min(zoomX, zoomY)
	targetZoom = max(targetZoom, fartherstZoom)
	targetZoom = min(targetZoom, closestZoom)
	
	zoom = Vector2(1,1) * targetZoom

func GetAveragePositionOfAllPlayers() -> Vector2:
	var summedPosition := Vector2.ZERO
	var players: Array = get_tree().get_nodes_in_group("Player")
	
	for player in players:
		summedPosition += player.global_position
		
	return summedPosition/players.size()
