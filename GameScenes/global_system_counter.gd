class_name GlobalSystemCounter
extends Node2D

var counterValue: int = 1

func GetSystemFromId(id: int) -> Node2D:
	var internalSystem = $"../Ship/SectionBuilder/InternalSystemBuilder".GetSystemFromId(id)
	var externalSystem = $"../Ship/ExternalSystemBuilder".GetSystemFromId(id)
	
	if internalSystem != null:
		return internalSystem
		
	if externalSystem != null:
		return externalSystem
		
	return null
