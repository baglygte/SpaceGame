extends Control
class_name ShipSelection

const skrt = preload("res://UI//ship_button.tscn")

func _ready() -> void:
	var saveManager: SaveManager = get_tree().get_first_node_in_group("SaveManager")
	
	saveManager.EnsureDirectoriesExist()
	
	var dir: DirAccess = DirAccess.open("user://saves//ships")
	
	var files = dir.get_files()

	for fileName in files:
		var button: Button = skrt.instantiate()
		
		button.text = fileName
		
		button.shipSelection = self
		
		$GridContainer.add_child(button)

func SelectShip(fileName: String) -> void:
	var manager: GameSceneManager = get_tree().get_first_node_in_group("GameSceneManager")
	
	manager.AddPersistentData({"savedShipFilePath": fileName})
	
	manager.ChangeActiveScene("res://GameScenes/game.tscn")
