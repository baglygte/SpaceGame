extends PanelContainer

func SetLabelText(text: String) -> void:
	$MarginContainer/Label.text = text

func SetReadyPanelColor() -> void:
	$MarginContainer/ColorRect.color = Color(0.429, 0.627, 0.293, 1.0)

func SetNotReadyPanelColor() -> void:
	$MarginContainer/ColorRect.color = Color(0.688, 0.245, 0.285, 1.0)
