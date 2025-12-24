class_name ConnectionBuilder
extends Node

var connectionSets : Array
const connectionScene = preload("res://Ship/system_connection.tscn")

func ConnectSystems(systemA, systemB, ship: Ship) -> void:
	var connection: SystemConnection = connectionScene.instantiate()
	ship.get_node("Connections").add_child(connection)
	
	connection.add_point(systemA.global_position)
	connection.add_point(systemB.global_position)
	connection.systemA = systemA
	connection.systemB = systemB
	
	connectionSets.append(connection)
	
	if systemA.has_method("OnConnection"): systemA.OnConnection(systemB)
	if systemB.has_method("OnConnection"): systemB.OnConnection(systemA)
		
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

func CreateFromSave(variablesToSet: Dictionary, ship) -> void:
	var systemAId = variablesToSet["systemAId"]
	var systemBId = variablesToSet["systemBId"]
	
	var systemA = $"../../GlobalSystemCounter".GetSystemFromId(systemAId)
	var systemB = $"../../GlobalSystemCounter".GetSystemFromId(systemBId)
	
	ConnectSystems(systemA, systemB, ship)
