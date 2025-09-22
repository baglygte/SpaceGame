extends CharacterBody2D
class_name Player

const SPEED = 100.0
var canMove := true

@onready var saveDataTracker: SaveDataTracker = $saveDataTracker

func _ready() -> void:
	saveDataTracker.creatorName = "PlayerCreator"
	saveDataTracker.AddVariableNameToSave("position")

func ReceiveMovement(movementVector: Vector2) -> void:
	if movementVector.length() == 0:
		return
	
	velocity = movementVector * SPEED
	move_and_slide()
	
func ReceiveLook(lookVector: Vector2) -> void:
	if lookVector.length() == 0:
		return
		
	self.rotation = lookVector.angle()

func ToggleEnterExit() -> void:
	var area: EnterExitArea = GetEnterExitArea()
	
	if area == null:
		return
		
	area.ToggleControl($PlayerInputListener)

func GetEnterExitArea() -> EnterExitArea:
	var areas = $EnterExitArea.get_overlapping_areas()
	
	for area: Area2D in areas:
		if area is EnterExitArea:
			return area
		
	return null
