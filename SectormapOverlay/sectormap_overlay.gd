class_name  SectorMapOverlay
extends SubViewport

var blipConnections: Dictionary
var ship: Ship

const visibleRange: float = 10000
		
func _ready() -> void:
	ship = get_tree().get_first_node_in_group("Ship")
	
func AddBlip(connection: SectorMapBlipConnector, blipType: String) -> void:
	var blip = GetBlip(blipType)
	
	blipConnections[connection] = blip
	$Control.add_child(blip)

func RemoveBlip(connection: SectorMapBlipConnector) -> void:
	blipConnections[connection].queue_free()
	blipConnections.erase(connection)
	
func _process(_delta: float) -> void:
	
	for connection in blipConnections.keys():
		var blip = blipConnections[connection]
		var deltaPosition: Vector2 = connection.get_parent().position - ship.position
		
		blip.position = deltaPosition.rotated(-ship.rotation) * (size.x / visibleRange)
		blip.rotation = connection.get_parent().rotation - ship.rotation
	

func GetBlip(blipType: String) -> Control:
	var texturePath: String
	
	match blipType:
		"EnemyRocket":
			texturePath = "res://sprites/Blips/RocketBlip.png"
		"EnemyShip":
			texturePath = "res://sprites/Blips/EnemyBlip.png"
			
	var blip = load("res://SectormapOverlay/blip.tscn").instantiate()
	blip.get_node("Sprite2D").texture = load(texturePath)
	
	return blip
