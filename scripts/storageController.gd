extends Node2D

var inputManager
var hud : HUD
var inventory: Array
var inventoryIsShown := false
var uiInventory: UIInventory

@onready var interactiveRegion: InteractiveRegion = $interactiveRegion
const UIInventoryScene = preload("res://scenes/uiInventory.tscn")
const wallScene = preload("res://scenes/wall.tscn")

func _ready() -> void:
	interactiveRegion.interactedWithSignal.connect(ShowInventory)
	inputManager.interactSignal.connect(interactiveRegion.InteractedWith)
	
	uiInventory = UIInventoryScene.instantiate()
	hud.AddUIElement(uiInventory)

func ShowInventory(player: Player) -> void:
	if player.playerInventory.heldItem != null:
		AddToInventory(player.playerInventory.heldItem)
		player.playerInventory.ClearHeldItem()
		return

	if inventoryIsShown:
		player.AssignMoveSignal(inputManager.moveSignal)
		inventoryIsShown = false
	else:
		uiInventory.player = player
		inputManager.ClearSignal(inputManager.moveSignal)
		inventoryIsShown = true
	
	uiInventory.visible = inventoryIsShown

func AddToInventory(itemToAdd) -> void:
	itemToAdd.get_parent().remove_child(itemToAdd)
	inventory.append(itemToAdd)
	uiInventory.AddItem(itemToAdd)
