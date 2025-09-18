extends Control

var gameSceneManager

func _ready() -> void:
	$VBoxContainer/NewGame.pressed.connect(StartNewGame)
	$VBoxContainer/LoadGame.pressed.connect(LoadGame)
	
func StartNewGame() -> void:
	gameSceneManager.ChangeActiveScene("res://GameScenes/deviceAssignment.tscn")
	
func LoadGame() -> void:
	var saveManager: SaveManager = get_tree().get_first_node_in_group("SaveManager")
	saveManager.shouldLoadGame = true
	gameSceneManager.ChangeActiveScene("res://GameScenes/deviceAssignment.tscn")
