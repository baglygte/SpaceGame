extends Control

var gameSceneManager

func _ready() -> void:
	$VBoxContainer/NewGame.pressed.connect(StartNewGame)
	$VBoxContainer/LoadGame.pressed.connect(LoadGame)
	
func StartNewGame() -> void:
	gameSceneManager.ChangeActiveScene("res://GameScenes/deviceAssignment.tscn")
	
func LoadGame() -> void:
	print("load game")
