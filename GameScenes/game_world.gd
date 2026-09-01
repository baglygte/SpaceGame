extends SubViewport
class_name GameWorld

func _ready() -> void:	
	CreateGameWorld()
	
	var creator = $"../ContainedItemCreator"
	var internalBuilder = $"../ShipCreator/InternalSystemBuilder"
	var externalBuilder = $"../ShipCreator/ExternalSystemBuilder"
	# Sections
	for i in range(20):
		creator.SpawnItemInWorld(load("res://Systems/section.tscn").instantiate(), Vector2(0,0))
		#
	## Systems
	for i in range(5):
		creator.SpawnItemInWorld(internalBuilder.CreateInternalSystem("res://Systems/ControlSeat/controlSeat.tscn"), Vector2(-50,-25))
		creator.SpawnItemInWorld(internalBuilder.CreateInternalSystem("res://Systems/FlightControl/flightControl.tscn"), Vector2(-75,-25))
		creator.SpawnItemInWorld(load("res://Systems/ammoDepot/ammoDepot.tscn").instantiate(), Vector2(-25, 150))
		creator.SpawnItemInWorld(externalBuilder.CreateExternalSystem("res://Systems/Thruster/thruster.tscn"), Vector2(-25,0))
		
	creator.SpawnItemInWorld(externalBuilder.CreateExternalSystem("res://Systems/Gun/gun.tscn"), Vector2(-25,50))
	creator.SpawnItemInWorld(externalBuilder.CreateExternalSystem("res://Systems/GrabberArm/grabber_arm.tscn"), Vector2(-25,100))
	creator.SpawnItemInWorld(externalBuilder.CreateExternalSystem("res://Systems/FuelTank/fuelTank.tscn"), Vector2(-25,150))
		
	var instance = load("res://Enemies/dabox.tscn").instantiate()
	add_child(instance)
	instance.position = Vector2(-10000,10000)
			
	add_child(load("res://Rockets/Recipes/rocket_recipes.tscn").instantiate())
			
	#$ContainedItemCreator.SpawnItemInWorld(load("res://Items/ball.tscn").instantiate(), Vector2(-50,200))
	#var instance = load("res://Enemies/Rock.tscn").instantiate()
	#add_child(instance)
	#instance.position = Vector2(2000,2000)
	
func CreateGameWorld() -> void:
	var saveManager: SaveManager = get_tree().get_first_node_in_group("SaveManager")
	
	if saveManager.shouldLoadGame:
		saveManager.LoadGame()
		var someShip = get_tree().get_first_node_in_group("Ship")
		$"../PlayerCreator".CreateNewPlayers(someShip)
	else:
		var manager: GameSceneManager = get_tree().get_first_node_in_group("GameSceneManager")
		
		var ship: Ship
		
		if manager.persistentData.has("savedShipFilePath"):
			var data = saveManager.ReadFile("ships//" + manager.persistentData["savedShipFilePath"])

			ship = $"../ShipCreator".CreateFromSave(data[0])
			
			ship.position = Vector2.ZERO
		else:
			ship = $"../ShipCreator".CreateShip()
		
		$"../PlayerCreator".CreateNewPlayers(ship)

func AddNodeToShip(node: Node) -> void:
	if node.get_parent() == null:
		$Ship.add_child(node)
	else:
		node.reparent($Ship)
