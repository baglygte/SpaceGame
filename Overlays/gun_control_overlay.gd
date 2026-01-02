class_name GunControlOverlay
extends Control

var rotationReference

func SetShip(shipToSet: Ship):
	$MarginContainer/SectorMapOverlay.SetShip(shipToSet)

func _process(_delta: float) -> void:
	if rotationReference == null:
		return

	$MarginContainer/Control.rotation = rotationReference.rotation - PI/2
