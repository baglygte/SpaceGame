class_name SystemConnection
extends Line2D

var systemA
var systemB

func GetSaveData() -> Dictionary:
	var dictionaryToSave: Dictionary
	
	dictionaryToSave["systemAId"] = systemA.globalId
	dictionaryToSave["systemBId"] = systemB.globalId
	
	return dictionaryToSave

func Kill():
	var builder = get_tree().get_first_node_in_group("ShipCreator").get_node("ConnectionBuilder")
	
	builder.BreakConnection(self)
	
	queue_free()
