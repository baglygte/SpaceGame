extends Node2D
class_name SaveDataTracker

# Contains information used to serialize (and deserialize) a node for saving/loading
# A node has variables to set, a scene to instantiate from, and a parent node to be added to

var creatorName: String
var variableNamesToSave: Array

func AddVariableNameToSave(variableName: String) -> void:
	variableNamesToSave.append(variableName)
	
func GetAllSaveVariables() -> Dictionary:
	var dictionaryToSave: Dictionary = {"creator": creatorName}

	for variableName: String in variableNamesToSave:
		var variableValue = get_parent().get(variableName)
		
		if variableValue is Vector2:
			dictionaryToSave[variableName + ".x"] = variableValue.x
			dictionaryToSave[variableName + ".y"] = variableValue.y
		else:
			dictionaryToSave[variableName] = variableValue
	
	return dictionaryToSave
