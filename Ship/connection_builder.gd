class_name ConnectionBuilder
extends Node2D

var connectionSets : Array
const connectionScene = preload("res://Ship/system_connection.tscn")

func ConnectSystems(systemA, systemB) -> void:
	var connection: SystemConnection = connectionScene.instantiate()
	add_child(connection)
	
	connection.add_point(systemA.position)
	connection.add_point(systemB.position)
	connection.systemA = systemA
	connection.systemB = systemB
	
	connectionSets.append(connection)
	
	var signalerA = GetSignaler(systemA)
	var signalerB = GetSignaler(systemB)
	
	if signalerA is SignalEmitter:
		signalerA.AddReceiver(signalerB)
	elif signalerB is SignalEmitter:
		signalerB.AddReceiver(signalerA)
		
func GetSignaler(item: Node2D) -> Node2D:
	if item == null:
		return null
		
	var children = item.get_children()
	
	for child in children:
		if child.is_in_group("signaler"):
			return child
		
	return null

func CreateFromSave(variablesToSet: Dictionary) -> void:
	var systemAId = variablesToSet["systemAId"]
	var systemBId = variablesToSet["systemBId"]
	
	var systemA = $"../SystemBuilder".GetSystemFromId(systemAId)
	var systemB = $"../SystemBuilder".GetSystemFromId(systemBId)
	
	ConnectSystems(systemA, systemB)
