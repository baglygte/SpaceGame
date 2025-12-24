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
	
	$WallBuilder.UpdateExternalWalls(ship)

func IsSectionPositionValid(positionToCheck: Vector2, ship: Ship) -> bool:
	if IsPositionOccupied(positionToCheck, ship):
		return false
		
	return true

func IsPositionOccupied(positionToCheck: Vector2, ship: Ship) -> bool:
	for section in ship.GetSections():
		if section.global_position == positionToCheck:
			return true
		
	return false

func WillRemovalLeadToDisconnection(positionToCheck: Vector2, ship: Ship) -> bool:
	var sections = ship.GetSections()
	var copiedSections: Array[Node]
	
	for section in sections:
		if section.position == positionToCheck:
			continue
		copiedSections.append(section.duplicate())
		
	var numberOfRegions = $BreadthFirstSearcher.GetNumberOfRegions(copiedSections)
	
	return numberOfRegions > 1

func AddSectionAtPosition(section, positionToGet: Vector2, rotationToGet: float, ship: Ship) -> void:
	section.global_position = positionToGet
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

func ExtractSectionAtPosition(positionToRemove: Vector2, ship: Ship) -> Node2D:
	if not IsPositionOccupied(positionToRemove, ship):
		return null
		
	var splitShip := false
	
	if WillRemovalLeadToDisconnection(positionToRemove, ship):
		splitShip = true
		
	var extractedSection
	
	for section in ship.GetSections():	
		if section.position != positionToRemove:
			continue
			
		ship.get_node("Sections").remove_child(section)
		$WallBuilder.UpdateExternalWalls(ship)
		extractedSection = section
		break
	
	if splitShip:
		SplitShip(ship)
		
	return extractedSection
	
func CreateFromSave(variablesToSet: Dictionary, ship: Ship) -> void:
	var section = sectionScene.instantiate()
	var positionToGet = Vector2(variablesToSet["position.x"], variablesToSet["position.y"])
	var rotationToGet = variablesToSet["rotation"]
	
	AddSectionAtPosition(section, positionToGet, rotationToGet,ship)
	
	for systemToSet in variablesToSet["internalSystems"]:
		$"../InternalSystemBuilder".CreateFromSave(systemToSet, section)
		
func SplitShip(ship):
	var shipSections = ship.get_node("Sections").get_children()
	var regions = $BreadthFirstSearcher.ExtractAllRegions(shipSections)
	
	for region in regions:
		var newShip: Ship = $"..".CreateShipWithSections(region)
		
		for child in ship.get_children():
			if not child is Player:
				continue
				
			if IsPlayerInRegion(region, child):
				child.reparent(newShip)
	
	ship.queue_free()

func IsPlayerInRegion(region: Array[Node], player: Player) -> bool:
	for section in region:
		var isRightOfEdge =  player.position.x >= section.position.x - 64.0/2
		if not isRightOfEdge:
			continue
			
		var isLeftOfEdge =  player.position.x <= section.position.x + 64.0/2
		if not isLeftOfEdge:
			continue
		
		var isAboveEdge = player.position.y >= section.position.y - 64.0/2
		if not isAboveEdge:
			continue
		
		var isBelowEdge = player.position.y <= section.position.y + 64.0/2
		if not isBelowEdge:
			continue
		
		return true
		
	return false
	
