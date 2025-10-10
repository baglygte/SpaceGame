class_name AmmoDepot
extends Node2D

var globalId: int
var ship: Ship
var logNode
var isOverlay = false
var recipes

func _ready() -> void:
	ship = get_tree().get_first_node_in_group("Ship")
	logNode = load("res://logisticNodes/logisticNode.tscn").instantiate()
	add_child(logNode)
	logNode.store.resize(5)
	logNode.itemType = "Rockets"

func OnConnection(target) -> void:
	if not "logNode" in target: return
	if target.logNode.itemType != logNode.itemType: return
	logNode.AddConnection(target.logNode)

func OnEnterExit(player: Player) -> void:
	if player == null: return
	if isOverlay:
		isOverlay = false
		logNode.get_node("LogisticsDebugger").eraseHUD()
	else:
		isOverlay = true
		logNode.get_node("LogisticsDebugger").DrawHUD()

func OnRightHand() -> void:
	recipes = get_tree().get_first_node_in_group("RocketRecipes")
	logNode.AddItem(recipes.Recipes["SplitRocket"])

func OnLeftHand() -> void:
	logNode.RemoveItem()

func GetSaveData() -> Dictionary:
	var dictionaryToSave: Dictionary = {"creator": "InternalSystemBuilder"}
	
	dictionaryToSave["systemType"] = "ammoDepot"
	var section: Section = get_parent().get_parent()
	dictionaryToSave["position.x"] = position.x + section.position.x
	dictionaryToSave["position.y"] = position.y + section.position.y
	dictionaryToSave["rotation"] = rotation
	dictionaryToSave["globalId"] = globalId
	
	return dictionaryToSave
