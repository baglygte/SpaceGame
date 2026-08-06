extends Control

func _ready() -> void:
	$VBoxContainer/NewGame.pressed.connect(StartNewGame)
	
	$VBoxContainer/LoadGame.pressed.connect(LoadGame)
	
	$VBoxContainer/ShipDesigner.pressed.connect(GoToShipDesigner)
	
func StartNewGame() -> void:
	ChangeToScene("res://GameScenes/game.tscn")
	
func LoadGame() -> void:
	var saveManager: SaveManager = get_tree().get_first_node_in_group("SaveManager")
	
	saveManager.shouldLoadGame = true
	
	ChangeToScene("res://GameScenes/game.tscn")

func GoToShipDesigner() -> void:
	ChangeToScene("res://GameScenes/shipDesigner.tscn")

func ChangeToScene(path: String) -> void:
	var gameSceneManager = get_tree().get_first_node_in_group("GameSceneManager")
	
	gameSceneManager.SetDestinationScene(path)
	
	gameSceneManager.ChangeActiveScene("res://GameScenes/deviceAssignment.tscn")
