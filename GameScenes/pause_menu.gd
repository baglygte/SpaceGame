extends Control
class_name PauseMenu

var gameIsPaused: bool = false
func _ready() -> void:
	$VBoxContainer/Resume.pressed.connect(TogglePause)
	
	$VBoxContainer/SaveGame.pressed.connect(SaveGame)
	
	$VBoxContainer/ReturnToMenu.pressed.connect(ReturnToMenu)

func TogglePause() -> void:
	if gameIsPaused:
		get_tree().paused = false
		
		hide()
	else:
		get_tree().paused = true
		
		show()
		
	gameIsPaused = !gameIsPaused

func ReturnToMenu() -> void:
	TogglePause()
	
	var gameSceneManager: GameSceneManager = get_tree().get_first_node_in_group("GameSceneManager")
	
	gameSceneManager.RemovePersistentData("deviceIds")
	
	gameSceneManager.ChangeActiveScene("res://GameScenes/mainMenu.tscn")

func SaveGame() -> void:
	TogglePause()
	
	var saveManager: SaveManager = get_tree().get_first_node_in_group("SaveManager")
	
	saveManager.Save()
