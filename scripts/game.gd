extends Node2D
class_name Game

var gameSceneManager: GameSceneManager

#const playerScene = preload("res://scenes/player.tscn")
const physicalItemScene = preload("res://scenes/physicalItem.tscn")

func _ready() -> void:	
	#SpawnPlayer()
	
	var physicalItem = physicalItemScene.instantiate()
	physicalItem.ContainItem($ModuleGenerator.CreateShipModule())
	$Ship.add_child(physicalItem)
	physicalItem.position = Vector2(200,0)
	
	physicalItem = physicalItemScene.instantiate()
	physicalItem.ContainItem($ModuleGenerator.CreateStorageModule())
	$Ship.add_child(physicalItem)
	physicalItem.position = Vector2(200,50)
	
	CreateThrusters()

#func SpawnPlayer() -> void:
	#var player = playerScene.instantiate() as Player
	#player.AssignMoveSignal($InputManager.moveSignal)
	#$ModuleGenerator.player = player
	#$Ship.AddPlayer(player)
	
func AddNodeToShip(node: Node) -> void:
	if node.get_parent() == null:
		$Ship.add_child(node)
	else:
		node.reparent($Ship)

func CreateThrusters() -> void:
	var physicalItem = physicalItemScene.instantiate()
	physicalItem.ContainItem($ModuleGenerator.CreateThrusterModule())
	$Ship.add_child(physicalItem)
	physicalItem.position = Vector2(200,100)

	physicalItem = physicalItemScene.instantiate()
	physicalItem.ContainItem($ModuleGenerator.CreateThrusterModule())
	$Ship.add_child(physicalItem)
	physicalItem.position = Vector2(200,100)
	
	physicalItem = physicalItemScene.instantiate()
	physicalItem.ContainItem($ModuleGenerator.CreateThrusterModule())
	$Ship.add_child(physicalItem)
	physicalItem.position = Vector2(200,100)
	
	physicalItem = physicalItemScene.instantiate()
	physicalItem.ContainItem($ModuleGenerator.CreateThrusterModule())
	$Ship.add_child(physicalItem)
	physicalItem.position = Vector2(200,100)
