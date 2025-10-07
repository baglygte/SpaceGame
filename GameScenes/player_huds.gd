class_name PlayerHuds
extends HBoxContainer

func ClearHud(side: String) -> void:
	if side == "Left":
		$LeftPlayerHud.get_child(0).queue_free()
	elif side == "Right":
		$RightPlayerHud.get_child(0).queue_free()

func ShowFlightControlOverlay(side: String) -> void:
	var overlay = load("res://Overlays/flight_control_overlay.tscn").instantiate()
	
	if side == "Left":
		$LeftPlayerHud.add_child(overlay)
	elif side == "Right":
		$RightPlayerHud.add_child(overlay)
	
func ShowGunControlOverlay(side: String, rotationReference, rotationOffset) -> void:
	var overlay: GunControlOverlay = load("res://Overlays/gun_control_overlay.tscn").instantiate()
	
	overlay.rotationReference = rotationReference
	overlay.rotationOffset = rotationOffset
	
	if side == "Left":
		$LeftPlayerHud.add_child(overlay)
	elif side == "Right":
		$RightPlayerHud.add_child(overlay)
