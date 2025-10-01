extends SubViewport
class_name GameWorld

func _ready() -> void:	
	StartGameScene()
	
	# Sections
	for i in range(20):
		$ContainedItemCreator.SpawnItemInWorld(load("res://Sections/section.tscn").instantiate(), Vector2(250,50))
		
	# Tools
	$ContainedItemCreator.SpawnItemInWorld(load("res://Tools/Hammer/hammer.tscn").instantiate(), Vector2(50,25))
	$ContainedItemCreator.SpawnItemInWorld(load("res://Tools/Wrench/wrench.tscn").instantiate(), Vector2(50,50))
	$ContainedItemCreator.SpawnItemInWorld(load("res://Tools/Pliers/pliers.tscn").instantiate(), Vector2(50,75))
	
	# Systems
	for i in range(5):
		$ContainedItemCreator.SpawnItemInWorld($Ship/SectionBuilder/InternalSystemBuilder.CreateInternalSystem("res://Systems/ControlSeat/controlSeat.tscn"), Vector2(200,90))
	for i in range(10):
		$ContainedItemCreator.SpawnItemInWorld($Ship/ExternalSystemBuilder.CreateExternalSystem("res://Systems/Thruster/thruster.tscn"), Vector2(200,130))
	$ContainedItemCreator.SpawnItemInWorld(load("res://Systems/Gun/gun.tscn").instantiate(), Vector2(200,170))
	$ContainedItemCreator.SpawnItemInWorld($Ship/SectionBuilder/InternalSystemBuilder.CreateInternalSystem("res://Systems/FlightControl/flightControl.tscn"), Vector2(200,210))
	
	var instance = load("res://Enemies/dabox.tscn").instantiate()
	add_child(instance)
	instance.position = Vector2(2000,2000)
	
func StartGameScene() -> void:
	var saveManager = get_tree().get_first_node_in_group("SaveManager")
	
	if saveManager.shouldLoadGame:
		saveManager.LoadGame()
		
	$PlayerCreator.CreateNewPlayers()
	
	#get_tree().root.get_node("MasterScene/Game/HUD/PlayerViewports").Initialize()

func AddNodeToShip(node: Node) -> void:
	if node.get_parent() == null:
		$Ship.add_child(node)
	else:
		node.reparent($Ship)
