class_name ObjectHover
extends Node

@export var hoverFilter: Array[String]
@export var hoverArea: Area2D
@export var spriteToShade: Node

var hoverRequesters: Array[PlayerReach]

func _ready():
	spriteToShade.material = ShaderMaterial.new()
	spriteToShade.material.shader = preload("res://section_preview.gdshader")
	spriteToShade.material.set("shader_parameter/shadedColor", Vector4(255,255,255,1))
	
	hoverArea.area_entered.connect(RequestHover)
	hoverArea.area_exited.connect(UnrequestHover)

func RequestHover(area: Area2D) -> void:
	if not area is PlayerReach:
		return
	
	if not area.WhatIsRequestingHover() in hoverFilter:
		return
		
	hoverRequesters.append(area)
	ToggleShader()
	
func UnrequestHover(area: Area2D) -> void:
	if not area is PlayerReach:
		return
	
	hoverRequesters.erase(area)
	
	ToggleShader()
	
func ToggleShader() -> void:
	var shadedColor
	if hoverRequesters.size() > 0:
		shadedColor = Vector4(0,255,0,1)
	else:
		shadedColor = Vector4(255,255,0,1)
		
	spriteToShade.material.set("shader_parameter/shadedColor", shadedColor)
