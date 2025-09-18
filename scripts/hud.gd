extends CanvasLayer
class_name HUD

@onready var inHandUI: InHandUi = $InHand

func _ready() -> void:
	queue_free()

func AddUIElement(elementToAdd: Control) -> void:
	get_child(0).add_child(elementToAdd)
