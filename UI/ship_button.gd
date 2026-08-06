extends Button
class_name ShipButton

var shipSelection: ShipSelection

func _ready() -> void:
	pressed.connect(skrt)
	
func skrt() -> void:
	shipSelection.SelectShip(text)
