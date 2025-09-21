extends Area2D

var numberOfHoverRequesters: int = 0

func RequestHover() -> void:
	numberOfHoverRequesters += 1
	ToggleLabelDisplay()
	
func UnrequestHover() -> void:
	numberOfHoverRequesters -= 1
	ToggleLabelDisplay()
	
func ToggleLabelDisplay() -> void:
	if numberOfHoverRequesters > 0:
		$PanelContainer.show()
	else:
		$"PanelContainer".hide()
