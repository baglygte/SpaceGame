extends Node
class_name ModuleGenerator

const moduleScene = preload("res://scenes/module.tscn")
const interactiveRegionScene = preload("res://scenes/interactiveRegion.tscn")
const shipControllerScene = preload("res://scenes/shipController.tscn")
const storageControllerScene = preload("res://scenes/storageController.tscn")
const thrusterControllerScene = preload("res://scenes/thrusterController.tscn")
var player: Player

func CreateStorageModule() -> Module:
	var module = moduleScene.instantiate()
	
	var storageController = storageControllerScene.instantiate()
	module.add_child(storageController)
	storageController.inputManager = $"../InputManager"
	storageController.hud = $"../HUD"

	module.name = "Storage"
	return module

func CreateShipModule() -> Module:
	var module = moduleScene.instantiate()
	
	var shipController = shipControllerScene.instantiate()
	shipController.inputManager = $"../InputManager"
	shipController.ship = $"../Ship"

	module.add_child(shipController)
	
	module.name = "Ship"
	return module
	
func CreateThrusterModule() -> Module:
	var module = moduleScene.instantiate()
	
	var thrusterController = thrusterControllerScene.instantiate()
	thrusterController.inputManager = $"../InputManager"

	module.add_child(thrusterController)
	
	module.name = "Thruster"
	return module
