extends Label

var ship: Ship
const characterMap = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

func _ready() -> void:
	ship = get_tree().get_first_node_in_group("Ship")
	
func _process(_delta: float) -> void:
	if ship == null:
		return
	var xText = int(round(ship.position.x / 1000))
	var yText = str(int(round(ship.position.y / 1000)))
	text = ConvertNumberToCharacter(xText) + ", " + yText

func ConvertNumberToCharacter(digit: int) -> String:
	return characterMap[digit]
