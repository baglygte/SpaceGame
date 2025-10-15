class_name SignalHybrid
extends Node2D

var signalConnection: Array

func AddConnection(connection) -> void:
	signalConnection.append(connection)
	var logNodeSelf = get_parent().get_node_or_null("logisticNode")
	var logNodeOther = connection.get_parent().get_node_or_null("logisticNode")
	if logNodeSelf != null and logNodeOther != null:
		if logNodeSelf.itemType == logNodeOther.itemType:
			logNodeSelf.AddConnection(logNodeOther)
