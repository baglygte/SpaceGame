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
	
	$"..".get_parent().GetOtherHand().LoseItem()
