class_name Section
extends Node2D

var mass: float = 100

func _ready() -> void:
	$Health.maxHealth = 2
	$Health.GainHealth(2)

func AddSystem(system) -> void:
	if system.get_parent() == null:
		$Systems.add_child(system)
	else:
		system.reparent($Systems)

func GetSystemFromId(id: int) -> Node2D:
	for child in $Systems.get_children():
		if child.globalId == id:
			return child
			
	return null
	
func GetSaveData() -> Dictionary:
	var dictionaryToSave: Dictionary
	
	dictionaryToSave["position.x"] = position.x
	dictionaryToSave["position.y"] = position.y
	dictionaryToSave["rotation"] = rotation
	
	var internalSystemDictionary: Array
	
	for internalSystem in $Systems.get_children():
		internalSystemDictionary.append(internalSystem.GetSaveData())
	
	dictionaryToSave["internalSystems"] = internalSystemDictionary
	
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
