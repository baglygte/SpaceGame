extends CharacterBody2D
class_name Player

const SPEED = 100.0
var canMove := true
@onready var playerInventory: PlayerInventory = $playerInventory

signal dropSignal

func _ready() -> void:
	dropSignal.connect($playerInventory.DropItem)
	playerInventory.ship = get_parent()

func AssignMoveSignal(moveSignal) -> void:
	moveSignal.connect(ReceiveMovement)

func ReceiveMovement(movementVector) -> void:
	if movementVector.length() == 0:
		return
	
	velocity = movementVector * SPEED
	move_and_slide()

func _process(_delta: float) -> void:
	#var mousePosition = get_viewport().get_camera_2d().get_global_mouse_position()
	#var diff: Vector2 = mousePosition - global_position
	#self.rotation = diff.angle()
	
	if Input.is_action_just_pressed("drop"):
		dropSignal.emit(self)
