extends PanelContainer
class_name ConnectedDevicePanel

var isReady: bool = false

func SetLabelText(text: String) -> void:
	$Label.text = text

func ToggleReady() -> void:
	if isReady:
		SetNotReady()
	else:
		SetReady()
	
func SetReady() -> void:
	isReady = true
	$ColorRect.color = Color(0.429, 0.627, 0.293, 1.0)

func SetNotReady() -> void:
	isReady = false
	$ColorRect.color = Color(0.688, 0.245, 0.285, 1.0)
