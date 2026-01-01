class_name ShipSplitter
extends Node

func SplitShip(ship: Ship):
	var sectionsAndExternalSystems = ship.GetSectionsAndExternalSystems()

	var regions = $BreadthFirstSearcher.ExtractAllRegions(sectionsAndExternalSystems)
	
	var originalVelocity = ship.linear_velocity
	
	for region in regions:
		var newShip: Ship = $"..".CreateShipWithSections(region, ship.position, ship.rotation)
		
		newShip.linear_velocity = originalVelocity
		
		for section: Section in newShip.GetSections():
			for system in section.get_node("Systems").get_children():
				if system.has_method("SetShip"):
					system.SetShip(newShip)
			
		for child in ship.get_children():
			if not child is Player:
				continue
				
			if IsPlayerInRegion(region, child):
				child.reparent(newShip)
				var playerHuds: PlayerHuds = get_tree().get_first_node_in_group("PlayerHuds")
				playerHuds.RefreshOverlaysWithNewShip(child.viewSide, newShip)
	
	for connection in ship.GetConnections():
		var aShip = GetSystemShip(connection.systemA)
		
		var bShip = GetSystemShip(connection.systemB)
		
		if aShip == bShip:
			aShip.AddConnection(connection)
		else:
			connection.Kill()
			
	ship.queue_free()

func GetSystemShip(system) -> Ship:
	if system.get_parent().get_parent() is Section:
		return system.get_parent().get_parent().get_parent().get_parent()
	else:
		return system.get_parent().get_parent()

func IsPlayerInRegion(region: Array[Node], player: Player) -> bool:
	var playerPosition: Vector2 = player.global_position
	for section: Node2D in region:
		var sectionPosition: Vector2 = section.global_position
		
		var isRightOfEdge =  playerPosition.x >= sectionPosition.x - 64.0/2
		if not isRightOfEdge:
			continue
			
		var isLeftOfEdge =  playerPosition.x <= sectionPosition.x + 64.0/2
		if not isLeftOfEdge:
			continue
		
		var isAboveEdge = playerPosition.y >= sectionPosition.y - 64.0/2
		if not isAboveEdge:
			continue
		
		var isBelowEdge = playerPosition.y <= sectionPosition.y + 64.0/2
		if not isBelowEdge:
			continue
		
		return true
		
	return false

func WillRemovalLeadToDisconnection(localPositionShip: Vector2, ship: Ship) -> bool:
	var sections = ship.GetSectionsAndExternalSystems()
	
	var copiedSections: Array[Node]
	
	for section in sections:
		if section.position == localPositionShip:
			continue
		copiedSections.append(section.duplicate())
		
	var numberOfRegions = $BreadthFirstSearcher.GetNumberOfRegions(copiedSections)

	return numberOfRegions > 1
