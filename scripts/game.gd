extends Node2D
class_name Game

var gameSceneManager: GameSceneManager

func _ready() -> void:	
	CreateStuff()
	
	$ContainedItemCreator.SpawnItemInShip(load("res://Sections/section.tscn").instantiate(), Vector2(200,0))
	$ContainedItemCreator.SpawnItemInShip(load("res://Sections/section.tscn").instantiate(), Vector2(200,50))
	
	$ContainedItemCreator.SpawnItemInShip(load("res://Items/Tools/hammer.tscn").instantiate(), Vector2(100,0))
	$ContainedItemCreator.SpawnItemInShip(load("res://Systems/starmap.tscn").instantiate(), Vector2(100,50))
	
	#CreateThrusters()

func CreateStuff() -> void:
	var saveManager = get_tree().get_first_node_in_group("SaveManager")
	if saveManager.shouldLoadGame:
		saveManager.LoadGame()
	else:
		$PlayerCreator.CreateNewPlayers()

func AddNodeToShip(node: Node) -> void:
	if node.get_parent() == null:
		$Ship.add_child(node)
	else:
		node.reparent($Ship)

#func CreateThrusters() -> void:
	#for xPos in [100, 150, 200, 250]:
		#$ContainedItemCreator.SpawnItemInShip($ModuleGenerator.CreateThrusterModule(), Vector2(200,xPos))	
