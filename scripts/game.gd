extends Node2D
class_name Game

var gameSceneManager: GameSceneManager

func _ready() -> void:	
	StartGameScene()
	
	# Sections
	for i in range(5):
		$ContainedItemCreator.SpawnItemInShip(load("res://Sections/section.tscn").instantiate(), Vector2(250,50))
		
	# Tools
	$ContainedItemCreator.SpawnItemInShip(load("res://Tools/Hammer/hammer.tscn").instantiate(), Vector2(150,50))
	$ContainedItemCreator.SpawnItemInShip(load("res://Tools/Pliers/pliers.tscn").instantiate(), Vector2(150,75))
	
	# Systems
	$ContainedItemCreator.SpawnItemInShip(load("res://Systems/Starmap/starmap.tscn").instantiate(), Vector2(200,50))
	$ContainedItemCreator.SpawnItemInShip(load("res://Systems/ControlSeat/controlSeat.tscn").instantiate(), Vector2(200,90))
	$ContainedItemCreator.SpawnItemInShip(load("res://Systems/ControlSeat/controlSeat.tscn").instantiate(), Vector2(200,90))
	$ContainedItemCreator.SpawnItemInShip(load("res://Systems/ControlSeat/controlSeat.tscn").instantiate(), Vector2(200,90))
	$ContainedItemCreator.SpawnItemInShip(load("res://Systems/ControlSeat/controlSeat.tscn").instantiate(), Vector2(200,90))
	$ContainedItemCreator.SpawnItemInShip(load("res://Systems/ControlSeat/controlSeat.tscn").instantiate(), Vector2(200,90))
	$ContainedItemCreator.SpawnItemInShip(load("res://Systems/ControlSeat/controlSeat.tscn").instantiate(), Vector2(200,90))
	$ContainedItemCreator.SpawnItemInShip(load("res://Systems/Thruster/thruster.tscn").instantiate(), Vector2(200,130))
	$ContainedItemCreator.SpawnItemInShip(load("res://Systems/Thruster/thruster.tscn").instantiate(), Vector2(200,130))
	$ContainedItemCreator.SpawnItemInShip(load("res://Systems/Thruster/thruster.tscn").instantiate(), Vector2(200,130))
	$ContainedItemCreator.SpawnItemInShip(load("res://Systems/Thruster/thruster.tscn").instantiate(), Vector2(200,130))
	$ContainedItemCreator.SpawnItemInShip(load("res://Systems/Gun/gun.tscn").instantiate(), Vector2(200,170))
	$ContainedItemCreator.SpawnItemInShip(load("res://Systems/FlightControl/flightControl.tscn").instantiate(), Vector2(200,210))

func StartGameScene() -> void:
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
