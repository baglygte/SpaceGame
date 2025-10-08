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
	recipes = get_tree().get_first_node_in_group("RocketRecipes")

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
	logNode.AddItem(recipes.Recipes["Main"])

func OnLeftHand() -> void:
	logNode.RemoveItem()
