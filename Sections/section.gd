class_name Section
extends Node2D

func _ready() -> void:
	$Health.maxHealth = 2
	$Health.GainHealth(2)
	
func GetSaveData() -> Dictionary:
	var dictionaryToSave: Dictionary = {"creator": "SectionBuilder"}
	
	dictionaryToSave["position.x"] = position.x
	dictionaryToSave["position.y"] = position.y
	dictionaryToSave["rotation"] = rotation
	
	return dictionaryToSave

func Kill() -> void:
	var systems = get_tree().get_nodes_in_group("System")
	
	for system in systems:
		if not IsPositionOnMe(system.position):
			continue
			
		system.Kill()
		
	queue_free()

func IsPositionOnMe(positionToCheck: Vector2) -> bool:
	var isWithinX : bool = false
	var isWithinY : bool = false
	
	if positionToCheck.x >= position.x - 32 and positionToCheck.x <= position.x + 32:
		isWithinX = true
		
	if positionToCheck.y >= position.y - 32 and positionToCheck.y <= position.y + 32:
		isWithinY = true
		
	return isWithinX and isWithinY
