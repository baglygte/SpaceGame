extends Node2D

var thingsToDisplay: Dictionary
var visibleRange = 720 * 0.5
var mapSize
const blipScene = preload("res://Systems/Starmap/starmapBlip.tscn")

func _ready() -> void:
	mapSize = $Sprite2D.texture.get_width() - 2
	var nodes = get_tree().get_nodes_in_group("VisibleOnStarmap")
	
	for node in nodes:
		AddBlipToMap(node)

func _process(_delta: float) -> void:	
	for node in thingsToDisplay.keys():
		var blip = thingsToDisplay[node]
		
		var blipPosition = node.global_position * (mapSize / visibleRange)
		
		blip.position = blipPosition
		
func AddBlipToMap(instance: Node2D) -> void:
	var blip = blipScene.instantiate()
	thingsToDisplay[instance] = blip
	$Sprite2D.add_child(blip)
