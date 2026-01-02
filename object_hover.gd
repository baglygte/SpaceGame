class_name ObjectHover
extends Node

@export var hoverFilter: Array[String]
@export var hoverArea: Area2D
@export var spriteToModulate: Sprite2D

var hoverRequesters: Array[PlayerReach]

func _ready():	
	hoverArea.area_entered.connect(RequestHover)
	
	hoverArea.area_exited.connect(UnrequestHover)

func RequestHover(area: Area2D) -> void:
	if not area is PlayerReach:
		return
	
	if not area.WhatIsRequestingHover() in hoverFilter:
		return
		
	hoverRequesters.append(area)
	
	ToggleModulation()
	
func UnrequestHover(area: Area2D) -> void:
	if not area is PlayerReach:
		return
	
	hoverRequesters.erase(area)
	
	ToggleModulation()
	
func ToggleModulation() -> void:
	if hoverRequesters.size() > 0:
		spriteToModulate.modulate = Color(0.914, 1.353, 0.793, 1.0)
	else:
		spriteToModulate.modulate = Color(1,1,1,1)
