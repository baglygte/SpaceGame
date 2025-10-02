extends SubViewport

var toggle: bool = false

func _ready() -> void:
	$Control/Camera2D.custom_viewport = self
	$Control2/Camera2D.custom_viewport = self

func _process(_delta: float) -> void:
	if not Input.is_action_just_pressed("start"):
		return
	
	if toggle:
		$Control/Camera2D.make_current()
	else:
		$Control2/Camera2D.make_current()
		
	toggle = !toggle
