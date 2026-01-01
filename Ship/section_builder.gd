class_name SectionBuilder
extends Node

var sectionMap: Dictionary
var sectionScene =  preload("res://Sections/section.tscn")

func CreateSectionAtPosition(sectionPosition: Vector2, sectionRotation: float) -> Section:
	var section: Section = sectionScene.instantiate()
	section.position = sectionPosition
	section.rotation = sectionRotation
	
	return section

func AddSectionToShip(section: Section, ship: Ship):
	ship.AddSection(section)
	
	for system in section.get_node("Systems").get_children():
		if not system.has_method("SetShip"):
			continue
			
		system.SetShip(ship)
	
	$WallBuilder.UpdateExternalWalls(ship)

func CanPlaceSectionAtPosition(localPositionOnShip: Vector2, ship: Ship) -> bool:
	if IsPositionOccupied(localPositionOnShip, ship):
		return false

	return IsNeighbouringSectorAtPosition(localPositionOnShip, ship)
	
func IsNeighbouringSectorAtPosition(localPositionOnShip: Vector2, ship: Ship) -> bool:
	var sections = ship.GetSections()
	
	var positions: Array[Vector2]
	
	positions.append(localPositionOnShip + Vector2.UP * 64)
	
	positions.append(localPositionOnShip + Vector2.RIGHT * 64)
	
	positions.append(localPositionOnShip + Vector2.DOWN * 64)
	
	positions.append(localPositionOnShip + Vector2.LEFT * 64)
	
	for section: Section in sections:
		if section.position in positions:
			return true
		
	return false

func IsSectionAtPosition(localPositionShip: Vector2, ship: Ship) -> bool:
	for section in ship.GetSections():
		if section.position == localPositionShip:
			return true
		
	return false
	
func IsPositionOccupied(localPositionShip: Vector2, ship: Ship) -> bool:
	for node in ship.GetSectionsAndExternalSystems():
		if node.position == localPositionShip:
			return true
		
	return false

func AddSectionAtPosition(section, globalPositionToGet: Vector2, rotationToGet: float, ship: Ship) -> void:
	section.global_position = globalPositionToGet
	section.rotation = rotationToGet

	AddSectionToShip(section, ship)
	
	#$"..".center_of_mass = GetCenterOfMass()
	#
	#var distance: float = ($"..".center_of_mass - section.position).length()
	#$"..".inertia += section.mass * pow(distance,2)

func GetCenterOfMass() -> Vector2:
	var totalMass: float = 0
	var totalMassDistanceX: float = 0
	var totalMassDistanceY: float = 0
	
	for child in get_children():
		if child is not Section:
			continue
			
		totalMass += child.mass
		totalMassDistanceX += child.mass * child.position.x
		totalMassDistanceY += child.mass * child.position.y
	
	var centerOfMass := Vector2(totalMassDistanceX/totalMass, totalMassDistanceY/totalMass)
	
	return centerOfMass

func ExtractSectionAtPosition(localPositionOnShip: Vector2, ship: Ship) -> Node2D:
	if not IsPositionOccupied(localPositionOnShip, ship):
		return null
		
	var splitShip := false
	
	if $"../ShipSplitter".WillRemovalLeadToDisconnection(localPositionOnShip, ship):
		splitShip = true
		
	var extractedSection
	
	for section in ship.GetSections():	
		if section.position != localPositionOnShip:
			continue
			
		ship.get_node("Sections").remove_child(section)
		$WallBuilder.UpdateExternalWalls(ship)
		extractedSection = section
		break
	
	if splitShip:
		$"../ShipSplitter".SplitShip(ship)
		
	return extractedSection

func DestroySection(section: Section):	
	var splitShip := false
	var ship: Ship = section.get_parent().get_parent()
	
	if $"../ShipSplitter".WillRemovalLeadToDisconnection(section.position, ship):
		splitShip = true
	
	section.reparent(self)
	
	if splitShip:
		$"../ShipSplitter".SplitShip(ship)

func CreateFromSave(variablesToSet: Dictionary, ship: Ship) -> void:
	var section = sectionScene.instantiate()
	var positionToGet = Vector2(variablesToSet["position.x"], variablesToSet["position.y"])
	var rotationToGet = variablesToSet["rotation"]
	
	AddSectionAtPosition(section, positionToGet, rotationToGet,ship)
	
	for systemToSet in variablesToSet["internalSystems"]:
		$"../InternalSystemBuilder".CreateFromSave(systemToSet, section)
