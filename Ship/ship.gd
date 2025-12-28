extends RigidBody2D
# The physical representation of the ship.
# Contains everything the player can interact with
# Modules, walls, etc.
class_name Ship

var shipId: int
var moveDirection := Vector2(0,0)
var assignedThrusters: Array

func _physics_process(_delta: float) -> void:
	if moveDirection.length() == 0:
		return
		
	apply_central_force(moveDirection * 200)

func GetSaveData() -> Dictionary:
	var dictionaryToSave: Dictionary = {"creator": "ShipCreator"}
	dictionaryToSave["id"] = shipId
	dictionaryToSave["position.x"] = position.x
	dictionaryToSave["position.y"] = position.y
	dictionaryToSave["rotation"] = rotation
	
	dictionaryToSave["sections"] = []
	
	for section in $Sections.get_children():
		dictionaryToSave["sections"].append(section.GetSaveData())
	
	dictionaryToSave["externalSystems"] = []
	
	for externalSystem in $ExternalSystems.get_children():
		dictionaryToSave["externalSystems"].append(externalSystem.GetSaveData())
		
	dictionaryToSave["connections"] = []
	
	for connection in $Connections.get_children():
		dictionaryToSave["connections"].append(connection.GetSaveData())
		
	return dictionaryToSave

func AddSection(section: Node2D):
	if section.get_parent() == null:
		$Sections.add_child(section)
	else:
		section.reparent($Sections, true)

func GetSections() -> Array[Node]:
	return $Sections.get_children()

func GetSectionsAndExternalSystems() -> Array[Node]:
	var sections = GetSections()
	
	sections.append_array(assignedThrusters)
	
	return sections
