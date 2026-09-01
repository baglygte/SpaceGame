extends AudioStreamPlayer2D
class_name AudioPlayer

var target: Node2D

func _ready() -> void:
	if target != null:
		global_position = target.global_position
	
	play()
	
func _process(_delta: float) -> void:
	if target == null:
		stop()
		return
	
	global_position = target.global_position
