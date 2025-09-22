extends Area2D

var numberOfHoverRequesters: int = 0

func RequestHover() -> void:
	numberOfHoverRequesters += 1
	ToggleHover()
	
func UnrequestHover() -> void:
	numberOfHoverRequesters -= 1
	ToggleHover()
	
func ToggleHover() -> void:
	if numberOfHoverRequesters > 0:
		$"Sprite2D2".show()
	else:
		$"Sprite2D2".hide()
