extends Node
class_name SaveManager

const savePath = "user://savegame.save"

var shouldLoadGame: bool = false
var instancesToAdd: Dictionary

func SaveGame() -> void:
	var nodesToSave = get_tree().get_nodes_in_group("MustBeSaved")
	
	var dataToSave: Array
	
	for node in nodesToSave:
		var saveInfo = node.GetSaveData()
		dataToSave.append(saveInfo)
	
	var save_file = FileAccess.open(savePath, FileAccess.WRITE)

	var json_string = JSON.stringify(dataToSave)

	save_file.store_line(json_string)

func LoadGame() -> void:
	var save_file = FileAccess.open(savePath, FileAccess.READ)
	
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()

		var json = JSON.new()

		var parse_result = json.parse(json_string)
		
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object.
		var objectsToLoad = json.data
		
		for objectToLoad in objectsToLoad:
			var variablesToSet = objectToLoad
			
			var creatorName = objectToLoad["creator"]
			var creator = get_tree().get_first_node_in_group(creatorName)
			creator.CreateFromSave(variablesToSet)
