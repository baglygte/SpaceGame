extends CanvasLayer
class_name HUD

@onready var inHandUI: InHandUi = $InHand

func AddUIElement(elementToAdd: Control) -> void:
	get_child(0).add_child(elementToAdd)
