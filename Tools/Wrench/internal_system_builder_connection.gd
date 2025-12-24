class_name IntenalSystemBuilderConnection
extends Node2D

var internalSystemBuilder: InternalSystemBuilder
var ship: Ship

func initialize(inputShip: Ship) -> void:
	internalSystemBuilder = get_tree().get_first_node_in_group("ShipCreator").get_node("InternalSystemBuilder")
	ship = inputShip

func GetPreviewPosition() -> Vector2:	
	return $"..".player.position + Vector2(64,0).rotated($"..".player.rotation)

func PlaceHeldSystem(system, angle: float) -> void:
	var previewPosition = GetPreviewPosition()
	
	if !internalSystemBuilder.IsSystemPositionValid(previewPosition, ship):
		return
		
	internalSystemBuilder.AddSystemAtPosition(system, previewPosition, angle, ship)	
	if system.has_method("OnPlace"):
		system.OnPlace()
		
	$"..".mainHand.LoseItem()
	
func UpdatePreviewPosition(preview) -> void:
	preview.position = GetPreviewPosition()
	
	var sprite: Sprite2D = preview.get_node("Sprite2D")
	
	var shadedColor = Vector4(255,0,0,0.5)
	
	if internalSystemBuilder.IsSystemPositionValid(preview.position, ship):
		shadedColor = Vector4(0,255,0,0.5)
		
	sprite.material.set("shader_parameter/shadedColor", shadedColor)
