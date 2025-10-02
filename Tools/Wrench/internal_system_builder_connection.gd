class_name IntenalSystemBuilderConnection
extends Node2D

var internalSystemBuilder: InternalSystemBuilder

func initialize() -> void:
	internalSystemBuilder = $"..".ship.get_node("SectionBuilder/InternalSystemBuilder")

func GetPreviewPosition() -> Vector2:	
	return $"..".player.position + Vector2(64,0).rotated($"..".player.rotation)

func PlaceHeldSystem(system, angle: float) -> void:
	var previewPosition = GetPreviewPosition()
	
	if !internalSystemBuilder.IsSystemPositionValid(previewPosition):
		return
		
	internalSystemBuilder.AddSystemAtPosition(system, previewPosition, angle)	
	if system.has_method("OnPlace"):
		system.OnPlace()
		
	$"..".get_parent().GetOtherHand().LoseItem()
	
func UpdatePreviewPosition(preview) -> void:
	preview.position = GetPreviewPosition()
	var sprite: Sprite2D = preview.get_node("Sprite2D")
	
	var shadedColor = Vector4(255,0,0,0.5)
	
	if internalSystemBuilder.IsSystemPositionValid(preview.position):
		shadedColor = Vector4(0,255,0,0.5)
		
	sprite.material.set("shader_parameter/shadedColor", shadedColor)
