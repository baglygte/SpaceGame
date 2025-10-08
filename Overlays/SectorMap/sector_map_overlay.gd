class_name  SectorMapOverlay
extends Control

var blips: Dictionary
var ship: Ship

const visibleRange: float = 10000
		
func _ready() -> void:
	ship = get_tree().get_first_node_in_group("Ship")
	
	var blipConnectors = get_tree().get_nodes_in_group("BlipConnector")
	
	for blipConnector: SectorMapBlipConnector in blipConnectors:
		AddBlip(blipConnector)
	
func AddBlip(connection: SectorMapBlipConnector) -> void:
	var blip = GetBlip(connection.blipType)
	connection.wasKilled.connect(RemoveBlip)
	blips[connection] = blip
	$Control.add_child(blip)

func RemoveBlip(connection: SectorMapBlipConnector) -> void:
	blips[connection].queue_free()
	blips.erase(connection)
	
func _process(_delta: float) -> void:
	for connection in blips.keys():
			
		var blip = blips[connection]
		var deltaPosition: Vector2 = connection.get_parent().position - ship.position
		
		blip.position = deltaPosition.rotated(-ship.rotation) * (size.x / visibleRange)
		blip.get_node("Sprite2D").rotation = connection.get_parent().rotation - ship.rotation
		
		blip.get_node("Control/CenterContainer/Label").text = str(int(deltaPosition.length()))
	
func GetBlip(blipType: String) -> Control:
	var texturePath: String
	
	match blipType:
		"EnemyRocket":
			texturePath = "res://sprites/Blips/RocketBlip.png"
		"EnemyShip":
			texturePath = "res://sprites/Blips/EnemyBlip.png"
			
	var blip = load("res://Overlays/SectorMap/blip.tscn").instantiate()
	blip.get_node("Sprite2D").texture = load(texturePath)
	
	return blip
