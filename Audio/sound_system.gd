class_name SoundSystem
extends Node

@onready var soundPlayerScene = preload("res://Audio/soundPlayer.tscn")

func PlaySoundAtPosition(path: String, vector: Vector2):
	var soundPlayer: AudioStreamPlayer2D = soundPlayerScene.instantiate()
	soundPlayer.stream = load(path)
	soundPlayer.position = vector
	soundPlayer.finished.connect(soundPlayer.queue_free)
	get_tree().get_first_node_in_group("Ship").add_child(soundPlayer)
	soundPlayer.play()
