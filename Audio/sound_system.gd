class_name SoundSystem
extends AudioListener2D

@onready var singleAudioPlayer = preload("res://Audio/audioPlayerSingle.tscn")
@onready var loopingAudioPlayer = preload("res://Audio/audioPlayerLooping.tscn")

func _process(_delta: float) -> void:
	var players = get_tree().get_nodes_in_group("Player")
	
	var averagePlayerPosition := Vector2.ZERO
	
	for player:Player in players:
		averagePlayerPosition += player.global_position
		
	global_position = averagePlayerPosition / players.size()
	
func PlaySoundAtPosition(path: String, soundPosition: Vector2):
	var audioPlayer: AudioStreamPlayer2D = singleAudioPlayer.instantiate()
	audioPlayer.stream = load(path)
	audioPlayer.global_position = soundPosition
	audioPlayer.finished.connect(audioPlayer.queue_free)
	get_tree().root.add_child(audioPlayer)
	audioPlayer.play()

func PlayLoopingSoundAtNode(path: String, node: Node2D):
	var audioPlayer: AudioPlayer = loopingAudioPlayer.instantiate()
	audioPlayer.stream = load(path)
	audioPlayer.target = node
	audioPlayer.finished.connect(audioPlayer.play)
	get_tree().root.add_child(audioPlayer)
