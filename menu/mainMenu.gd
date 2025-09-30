extends Control

func _ready() -> void:
	$VBoxContainer/NewGame.pressed.connect(StartNewGame)
	$VBoxContainer/LoadGame.pressed.connect(LoadGame)
	
func StartNewGame() -> void:
	get_tree().get_first_node_in_group("GameSceneManager").ChangeActiveScene("res://GameScenes/deviceAssignment.tscn")
	
func LoadGame() -> void:
	var saveManager: SaveManager = get_tree().get_first_node_in_group("SaveManager")
	saveManager.shouldLoadGame = true
	get_tree().get_first_node_in_group("GameSceneManager").ChangeActiveScene("res://GameScenes/deviceAssignment.tscn")
