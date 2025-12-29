class_name GlobalSystemCounter
extends Node2D

var counterValue: int = 1

func GetSystemFromId(id: int) -> Node2D:
	for ship in get_tree().get_nodes_in_group("Ship"):
		var internalSystem = $"../ShipCreator/InternalSystemBuilder".GetSystemFromId(id, ship)
		var externalSystem = $"../ShipCreator/ExternalSystemBuilder".GetSystemFromId(id, ship)
		
		if internalSystem != null:
			return internalSystem
			
		if externalSystem != null:
			return externalSystem
			
	return null
