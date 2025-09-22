extends Node2D
class_name Game

var gameSceneManager: GameSceneManager

func _ready() -> void:	
	CreateStuff()
	
	# Sections
	for i in range(5):
		$ContainedItemCreator.SpawnItemInShip(load("res://Sections/section.tscn").instantiate(), Vector2(200,0))
		
	# Tools
	$ContainedItemCreator.SpawnItemInShip(load("res://Tools/Hammer/hammer.tscn").instantiate(), Vector2(100,0))
	$ContainedItemCreator.SpawnItemInShip(load("res://Tools/Pliers/pliers.tscn").instantiate(), Vector2(100,25))
	
	# Systems
	$ContainedItemCreator.SpawnItemInShip(load("res://Systems/Starmap/starmap.tscn").instantiate(), Vector2(150,0))
	$ContainedItemCreator.SpawnItemInShip(load("res://Systems/ControlSeat/controlSeat.tscn").instantiate(), Vector2(150,40))
	$ContainedItemCreator.SpawnItemInShip(load("res://Systems/Thruster/thruster.tscn").instantiate(), Vector2(150,80))
	$ContainedItemCreator.SpawnItemInShip(load("res://Systems/Gun/gun.tscn").instantiate(), Vector2(150,120))

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
