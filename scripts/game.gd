extends Node2D
class_name Game

var gameSceneManager: GameSceneManager

func _ready() -> void:	
	StartGameScene()
	
	# Sections
	for i in range(5):
		$ContainedItemCreator.SpawnItemInWorld(load("res://Sections/section.tscn").instantiate(), Vector2(250,50))
		
	# Tools
	$ContainedItemCreator.SpawnItemInWorld(load("res://Tools/Hammer/hammer.tscn").instantiate(), Vector2(50,25))
	$ContainedItemCreator.SpawnItemInWorld(load("res://Tools/Wrench/wrench.tscn").instantiate(), Vector2(50,50))
	$ContainedItemCreator.SpawnItemInWorld(load("res://Tools/Pliers/pliers.tscn").instantiate(), Vector2(50,75))
	
	# Systems
	$ContainedItemCreator.SpawnItemInWorld($Ship/SystemBuilder.CreateSystem("res://Systems/Starmap/starmap.tscn"), Vector2(200,50))
	for i in range(5):
		$ContainedItemCreator.SpawnItemInWorld($Ship/SystemBuilder.CreateSystem("res://Systems/ControlSeat/controlSeat.tscn"), Vector2(200,90))
	for i in range(5):
		$ContainedItemCreator.SpawnItemInWorld($Ship/SystemBuilder.CreateSystem("res://Systems/Thruster/thruster.tscn"), Vector2(200,130))
	$ContainedItemCreator.SpawnItemInWorld(load("res://Systems/Gun/gun.tscn").instantiate(), Vector2(200,170))
	$ContainedItemCreator.SpawnItemInWorld($Ship/SystemBuilder.CreateSystem("res://Systems/FlightControl/flightControl.tscn"), Vector2(200,210))

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
