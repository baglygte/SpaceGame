extends Node2D
# Handles placing and removing of elements on the ship
class_name ShipBuilder

var hoverItem: Node2D

@onready var ship: Ship = $".."
@onready var inputManager: InputManager = $"../../InputManager"

func _process(_delta: float) -> void:		
	HoverItem()
	
func HoverItem() -> void:
	if hoverItem == null:
		return
	
	var mousePosition = get_viewport().get_camera_2d().get_global_mouse_position()
	var shipPosition = ship.global_position
	var snappedPosition: Vector2
	
	snappedPosition.x = mousePosition.x - fmod(mousePosition.x, hoverItem.moduleWidth) + shipPosition.x
	snappedPosition.y = mousePosition.y - fmod(mousePosition.y, hoverItem.moduleWidth) + shipPosition.y
	
	hoverItem.global_position = snappedPosition

func SetHoverItem(itemToHover: Module) -> void:
	hoverItem = itemToHover
	
	inputManager.ClearSignal(inputManager.leftClickSignal)
	inputManager.leftClickSignal.connect(PlaceItem)
	
	inputManager.ClearSignal(inputManager.modifySignal)
	inputManager.modifySignal.connect(RotateItem)
	
	ship.call_deferred("add_child", hoverItem)

func ClearHoverItem() -> void:
	if hoverItem == null:
		return
	ship.remove_child(hoverItem)

func PlaceItem() -> void:
	if hoverItem is not Module:
		return

	if hoverItem.GetType() is ThrusterController:
		ship.AddThruster(hoverItem)
		
	ship.player.playerInventory.ClearHeldItem()
	hoverItem = null

func RotateItem() -> void:
	if hoverItem is not Module:
		return
	
	hoverItem.RotateByDegrees(90)
