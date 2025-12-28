class_name ShipCreator
extends Node

const shipScene = preload("res://Ship/ship.tscn")
var shipIdCounter: int = 0

func CreateShip() -> Ship:
	var ship: Ship = shipScene.instantiate()
	
	shipIdCounter += 1
	ship.shipId = shipIdCounter
	$"../GameWorld".add_child(ship)
	
	var section = $SectionBuilder.CreateSectionAtPosition(Vector2.ZERO, 0)
	$SectionBuilder.AddSectionToShip(section, ship)
	
	return ship

func CreateShipWithSections(sections: Array[Node]) -> Ship:
	var ship: Ship = shipScene.instantiate()
	ship.global_position = sections[0].global_position
	
	shipIdCounter += 1
	ship.shipId = shipIdCounter
	$"../GameWorld".add_child(ship)
	
	for section: Node in sections:
		if section.get_parent().name == "Sections":
			$SectionBuilder.AddSectionToShip(section, ship)
		elif section.get_parent().name == "ExternalSystems":
			$ExternalSystemBuilder.AddSystemAtPosition(section, section.global_position - ship.position, section.rotation, ship)
	
	return ship

func CreateFromSave(variablesToSet: Dictionary):
	var ship: Ship = shipScene.instantiate()
	
	var shipIdtoGet = variablesToSet["id"]
	ship.shipId = shipIdtoGet
	if shipIdCounter <= shipIdtoGet:
		shipIdCounter = shipIdtoGet + 1
		
	$"../GameWorld".add_child(ship)
	ship.position = Vector2(variablesToSet["position.x"], variablesToSet["position.y"])
	ship.rotation = variablesToSet["rotation"]
	
	for sectionVariables in variablesToSet["sections"]:
		$SectionBuilder.CreateFromSave(sectionVariables, ship)
		
	for externalSystemVariables in variablesToSet["externalSystems"]:
		$ExternalSystemBuilder.CreateFromSave(externalSystemVariables, ship)
		
	for connectionVariables in variablesToSet["connections"]:
		$ConnectionBuilder.CreateFromSave(connectionVariables, ship)

func FindShipWithId(shipId: int) -> Ship:
	var ships = get_tree().get_nodes_in_group("Ship")
	
	for ship: Ship in ships:
		if ship.shipId == shipId:
			return ship
			
	return null
