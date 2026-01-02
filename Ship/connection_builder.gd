class_name ConnectionBuilder
extends Node

var connectionSets : Array
const connectionScene = preload("res://Ship/system_connection.tscn")

func BreakConnection(connection: SystemConnection):
	var signalerA = GetSignaler(connection.systemA)
	
	var signalerB = GetSignaler(connection.systemB)
	
	if signalerA is SignalEmitter:
		signalerA.RemoveReciever(signalerB)
	elif signalerB is SignalEmitter:
		signalerB.RemoveReciever(signalerA)

func ConnectSystems(systemA, systemB, ship: Ship) -> void:
	if not ValidConnection(systemA, systemB):
		return
		
	var connection: SystemConnection = connectionScene.instantiate()
	
	ship.AddConnection(connection)
		
	connection.add_point(GetSystemConnectionPoint(systemA))
	
	connection.add_point(GetSystemConnectionPoint(systemB))
	
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
	elif signalerA is SignalHybrid:
		signalerA.AddConnection(signalerB)
		signalerB.AddConnection(signalerA)
		
func GetSystemConnectionPoint(system) -> Vector2:
	if system.get_parent().get_parent() is Section:
		return system.position + system.get_parent().get_parent().position
	else:
		return system.position
	
func ValidConnection(systemA, systemB) -> bool:
	var signalerA = GetSignaler(systemA)
	var signalerB = GetSignaler(systemB)
	
	if (signalerA is SignalEmitter) and (signalerB is SignalReceiver):
		return true
	elif (signalerB is SignalEmitter) and (signalerA is SignalReceiver):
		return true
	elif (signalerA is SignalHybrid) or (signalerB is SignalHybrid):
		return true
	return false

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
