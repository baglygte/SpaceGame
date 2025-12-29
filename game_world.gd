extends SubViewport
class_name GameWorld

func _ready() -> void:	
	CreateGameWorld()
	
	var creator = $"../ContainedItemCreator"
	var internalBuilder = $"../ShipCreator/InternalSystemBuilder"
	# Sections
	for i in range(20):
		creator.SpawnItemInWorld(load("res://Sections/section.tscn").instantiate(), Vector2(0,0))
		#
	## Systems
	#for i in range(5):
	creator.SpawnItemInWorld(internalBuilder.CreateInternalSystem("res://Systems/ControlSeat/controlSeat.tscn"), Vector2(-50,-25))
	creator.SpawnItemInWorld(internalBuilder.CreateInternalSystem("res://Systems/FlightControl/flightControl.tscn"), Vector2(-75,-25))
	
	for i in range(10):
		creator.SpawnItemInWorld(internalBuilder.CreateInternalSystem("res://Systems/Thruster/thruster.tscn"), Vector2(-25,25))
	#$ContainedItemCreator.SpawnItemInWorld($Ship/ExternalSystemBuilder.CreateExternalSystem("res://Systems/Gun/gun.tscn"), Vector2(200,170))
	#$ContainedItemCreator.SpawnItemInWorld($Ship/ExternalSystemBuilder.CreateExternalSystem("res://Systems/GrabberArm/grabber_arm.tscn"), Vector2(200,170))
	#$ContainedItemCreator.SpawnItemInWorld($Ship/SectionBuilder/InternalSystemBuilder.CreateInternalSystem("res://Systems/FlightControl/flightControl.tscn"), Vector2(200,210))
	#for i in range(10):
		#$ContainedItemCreator.SpawnItemInWorld(load("res://Systems/ammoDepot/ammoDepot.tscn").instantiate(), Vector2(200,40))
	#for i in [-2000,-1000,0,1000,2000]:
		#for j in [-2000,2000]:
			#var instance = load("res://Enemies/dabox.tscn").instantiate()
			#add_child(instance)
			#instance.position = Vector2(j,i)
	add_child(load("res://Rockets/Recipes/rocket_recipes.tscn").instantiate())
	
	#$ContainedItemCreator.SpawnItemInWorld(load("res://Items/ball.tscn").instantiate(), Vector2(-50,200))
	var instance = load("res://Enemies/Rock.tscn").instantiate()
	add_child(instance)
	instance.position = Vector2(2000,2000)
	
func CreateGameWorld() -> void:
	var saveManager = get_tree().get_first_node_in_group("SaveManager")
	
	if saveManager.shouldLoadGame:
		saveManager.LoadGame()
		var someShip = get_tree().get_first_node_in_group("Ship")
		$"../PlayerCreator".CreateNewPlayers(someShip)
	else:
		var ship = $"../ShipCreator".CreateShip()
		$"../PlayerCreator".CreateNewPlayers(ship)

func AddNodeToShip(node: Node) -> void:
	if node.get_parent() == null:
		$Ship.add_child(node)
	else:
		node.reparent($Ship)
