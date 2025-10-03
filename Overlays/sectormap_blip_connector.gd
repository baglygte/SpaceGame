class_name SectorMapBlipConnector
extends Node2D
# Anything that should appear on the sectormap should have this scene

var blipType
signal wasKilled

func Kill() -> void:
	wasKilled.emit(self)
