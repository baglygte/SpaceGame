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
	
	shipIdCounter += 1
	ship.shipId = shipIdCounter
	$"../GameWorld".add_child(ship)
	
	for section in sections:
		$SectionBuilder.AddSectionToShip(section, ship)
	
	return ship

func CreateFromSave(variablesToSet: Dictionary):
	var ship: Ship = shipScene.instantiate()
	
	var shipIdtoGet = variablesToSet["id"]
	ship.shipId = shipIdtoGet
	if shipIdCounter <= shipIdtoGet:
		shipIdCounter = shipIdtoGet + 1
		
	$"../GameWorld".add_child(ship)
	
	for sectionVariables in variablesToSet["sections"]:
		$SectionBuilder.CreateFromSave(sectionVariables, ship)

func FindShipWithId(shipId: int) -> Ship:
	var ships = get_tree().get_nodes_in_group("Ship")
	
	for ship: Ship in ships:
		if ship.shipId == shipId:
			return ship
			
	return null
