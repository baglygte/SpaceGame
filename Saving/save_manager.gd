extends Node
class_name SaveManager

const saveDirectories: Array = ["saves", "saves//ships"]

var shouldLoadGame: bool = false

func SaveGame() -> void:
	EnsureDirectoriesExist()
	
	var nodesToSave = get_tree().get_nodes_in_group("MustBeSaved")
	
	var saveData: Array
	
	for node in nodesToSave:
		var nodeSaveData: Dictionary = node.GetSaveData()
		
		if node.is_in_group("Ship"):		
			SaveData([nodeSaveData], "ships//ship.save")
			
			saveData.append({"shipDir": "ships//ship.save"})
			
			continue

		saveData.append(nodeSaveData)
	
	SaveData(saveData, "game.save")

func SaveData(dataToSave: Array, savePath: String) -> void:	
	var saveFile = FileAccess.open("user://saves//" + savePath, FileAccess.WRITE)

	saveFile.store_line(JSON.stringify(dataToSave))
	
func LoadGame() -> void:
	var fileContents: Array = ReadFile("game.save")
	
	for content: Dictionary in fileContents:
		if content.has("shipDir"):
			var shipFileContents = ReadFile(content["shipDir"])
			
			var shipCreator = get_tree().get_first_node_in_group("ShipCreator")
		
			shipCreator.CreateFromSave(shipFileContents[0])
			
			continue
	
	#LoadObjectsOfCreator("ShipCreator")
	
	LoadObjectsOfCreator("PlayerCreator", fileContents)

	LoadObjectsOfCreator("InternalSystemBuilder", fileContents)

func ReadFile(pathInSavesDirectory: String) -> Array:
	var file = FileAccess.open("user://saves//" + pathInSavesDirectory, FileAccess.READ)
	
	var json = JSON.new()
	
	while file.get_position() < file.get_length():
		var jsonString = file.get_line()

		json.parse(jsonString)

	return json.data
			
func LoadObjectsOfCreator(creatorName: String, fileContents: Array) -> void:
	for objectToLoad: Dictionary in fileContents:
		if not objectToLoad.has("creator"):
			continue
			
		if objectToLoad["creator"] != creatorName:
			continue
			
		var creator = get_tree().get_first_node_in_group(creatorName)
		
		creator.CreateFromSave(objectToLoad)

func EnsureDirectoriesExist() -> void:	
	var dir = DirAccess.open("user://")
	
	for expectedDirectory: String in saveDirectories:
		if dir.dir_exists(expectedDirectory):
			continue
		
		dir.make_dir("user://" + expectedDirectory)
