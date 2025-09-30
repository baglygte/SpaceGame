extends CharacterBody2D
class_name Player

const SPEED = 100.0
var canMove := true
var camera: Camera2D

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

func GetSaveData() -> Dictionary:
	var dictionaryToSave: Dictionary = {"creator": "PlayerCreator"}
	
	dictionaryToSave["position.x"] = position.x
	dictionaryToSave["position.y"] = position.y
	
	return dictionaryToSave
