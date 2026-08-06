extends HBoxContainer
class_name ShipButton

var shipSelection: ShipSelection

func _ready() -> void:
	$Button.pressed.connect(skrt)

func SetText(textToSet: String) -> void:
	$Button.text = textToSet
	
func skrt() -> void:
	shipSelection.SelectShip($Button.text)
