extends Node2D
class_name PlayerSpawner

const player = preload("res://player/player.tscn")

func _ready() -> void:
	var listeners = get_tree().get_nodes_in_group("PlayerInputListeners")
	
	for listener in listeners:
		var instance = player.instantiate()
		listener.AssignToPlayer(instance)
		get_parent().AddNodeToShip(instance)
