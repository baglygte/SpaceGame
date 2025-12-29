class_name ExtenalSystemBuilderConnection
extends Node2D

var externalSystemBuilder: ExternalSystemBuilder
const previewOffsetMap: Dictionary = {-180: Vector2(-64,0),
										-135: Vector2(-64,-64),
										-90: Vector2(0,-64),
										-45: Vector2(64,-64),
										0: Vector2(64,0),
										45: Vector2(64,64),
										90: Vector2(0,64),
										135: Vector2(-64,64),
										180: Vector2(-64,0)}
										
var ship: Ship
func initialize(inputShip: Ship) -> void:
	externalSystemBuilder = get_tree().get_first_node_in_group("ShipCreator").get_node("ExternalSystemBuilder")
	ship = inputShip

func GetPreviewPosition() -> Vector2:	
	var snappedRotation : int = snapped(rad_to_deg($"..".player.rotation), 45)
	
	var snappedPlayerPosition : Vector2
	snappedPlayerPosition.x = round($"..".player.position.x/64)*64
	snappedPlayerPosition.y = round($"..".player.position.y/64)*64
	
	var previewOffset: Vector2 = previewOffsetMap[snappedRotation]
	
	return snappedPlayerPosition + previewOffset

func PlaceHeldSystem(system, angle: float) -> void:
	var previewPosition = GetPreviewPosition()
	
	if !externalSystemBuilder.IsSystemPositionValid(previewPosition):
		return
	
	externalSystemBuilder.AddSystemAtPosition(system, previewPosition, angle, ship)	
	
	$"..".mainHand.LoseItem()

func UpdatePreviewPosition(preview) -> void:
	preview.position = GetPreviewPosition()
	var sprite: Sprite2D = preview.get_node("Sprite2D")
	
	var shadedColor = Vector4(255,0,0,0.5)
	
	if externalSystemBuilder.IsSystemPositionValid(preview.position):
		shadedColor = Vector4(0,255,0,0.5)
		
	sprite.material.set("shader_parameter/shadedColor", shadedColor)
