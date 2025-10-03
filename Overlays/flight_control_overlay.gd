extends Control

var ship: Ship
var compassSprite: Sprite2D
const angleMap = [0, 22.5, 45, 67.5, 90, 112.5,135, 157.5, 180, 202.5, 225, 247.5, 270, 292.5, 315, 337.5]
const frameMap = [0, 1, 2, 1, 0, 1, 2, 1, 0, 1, 2, 1, 0, 1, 2, 1]
const flipHMap = [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1]
const flipVMap = [0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0]
const rotateMap = [0, 0, 0, -90, 90, 90, 0, 0, 0, 0, 0, -90, -90, -90, -90, 0]

func _ready() -> void:
	ship = get_tree().get_first_node_in_group("Ship")
	compassSprite = $MarginContainer2/Control/CenterContainer/Sprite2D
	
func _process(_delta: float) -> void:
	if ship == null:
		return
	
	UpdateCompassFrame()
	#var xText = "x: " + str(round(ship.position.x / 100))
	#var yText = "y: " + str(round(ship.position.y / 100))
	#
	#$CenterContainer/HBoxContainer/VBoxContainer/xCoorLabel.text = xText
	#$CenterContainer/HBoxContainer/VBoxContainer/yCoorLabel.text = yText
	
	
func UpdateCompassFrame() -> void:
	var shipAngle = ship.rotation_degrees
	if shipAngle < 0:
		shipAngle += 360
	
	var angleIndex = 0
	
	for i in range(0, angleMap.size()):
		var angle = angleMap[i]
		if shipAngle < angle + 11.25 and shipAngle >= angle - 11.25:
			angleIndex = i
			break

	compassSprite.rotation_degrees = rotateMap[angleIndex]
	compassSprite.frame = frameMap[angleIndex]
	compassSprite.flip_h = flipHMap[angleIndex]
	compassSprite.flip_v = flipVMap[angleIndex]
