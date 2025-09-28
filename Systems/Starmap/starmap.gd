class_name Starmap
extends Node2D

var globalId: int
var blipsToDisplay: Dictionary
var visibleRange: float = 10000
var mapSize
var ship: Ship
const blipScene = preload("res://Systems/Starmap/starmapBlip.tscn")

func _ready() -> void:
	mapSize = $Sprite2D.texture.get_width() - 2
	ship = get_tree().get_first_node_in_group("Ship")
	

func _process(_delta: float) -> void:	
	for node in blipsToDisplay.keys():
		var blip = blipsToDisplay[node]
		
		var blipPosition = (node.position - ship.position)  * (mapSize / visibleRange)
		
		blip.position = blipPosition
		
func AddBlipToMap(instance: Node2D) -> void:
	var blip = blipScene.instantiate()
	blipsToDisplay[instance] = blip
	$Sprite2D.add_child(blip)

func RemoveBlipFromMap(instance: Node2D) -> void:
	if not instance in blipsToDisplay:
		return
		
	blipsToDisplay[instance].queue_free()
	blipsToDisplay.erase(instance)
	
func GetSaveData() -> Dictionary:
	var dictionaryToSave: Dictionary = {"creator": "InternalSystemBuilder"}
	
	dictionaryToSave["systemType"] = "starmap"
	dictionaryToSave["position.x"] = global_position.x
	dictionaryToSave["position.y"] = global_position.y
	dictionaryToSave["rotation"] = rotation
	dictionaryToSave["globalId"] = globalId
	
	return dictionaryToSave
