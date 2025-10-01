class_name  SectormapOverlay
extends MarginContainer

var blipConnections: Dictionary
var ship: Ship

const visibleRange: float = 10000
		
func _ready() -> void:
	ship = get_tree().get_first_node_in_group("Ship")
	
func AddBlip(connection: SectormapBlipConnector) -> void:
	var blip = load("res://Systems/Starmap/starmapBlip.tscn").instantiate()
	
	blipConnections[connection] = blip
	
	$Control.add_child(blip)

func RemoveBlip(connection: SectormapBlipConnector) -> void:
	blipConnections[connection].queue_free()
	blipConnections.erase(connection)
	
func _process(_delta: float) -> void:
	
	for connection in blipConnections.keys():
		var blip = blipConnections[connection]
		var nodePosition: Vector2 = connection.get_parent().position
		
		blip.position = (nodePosition - ship.position).rotated(-ship.rotation) * (size.x / visibleRange)
	
