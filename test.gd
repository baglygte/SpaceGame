extends SubViewport

func _ready() -> void:
	var skrt = $"../../SubViewport2".find_world_2d()
	$".".world_2d = skrt
