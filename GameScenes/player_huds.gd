class_name PlayerHuds
extends HBoxContainer

var playerHandSets: Dictionary
var activeOverlayLeft
var activeOverlayRight

func RefreshOverlaysWithNewShip(side: String, ship: Ship):
	var overlay
	if side == "Left":
		overlay = activeOverlayLeft
	elif side == "Right":
		overlay = activeOverlayRight
	
	if overlay == null:
		return
		
	if overlay.has_method("SetShip"):
		overlay.SetShip(ship)
	

func ClearHud(side: String) -> void:
	if side == "Left":
		activeOverlayLeft.queue_free()
	elif side == "Right":
		activeOverlayRight.queue_free()

func SetActiveOverlay(side: String, overlay):
	if side == "Left":
		$LeftPlayerHud.add_child(overlay)
		activeOverlayLeft = overlay
	elif side == "Right":
		$RightPlayerHud.add_child(overlay)
		activeOverlayRight = overlay
	
func AddItemToHands(player: Player, hand, item) -> void:
	playerHandSets[player].AddItem(hand, item)
	
func RemoveItemFromHands(player: Player, hand) -> void:
	playerHandSets[player].RemoveItem(hand)
	
func ShowFlightControlOverlay(side: String, ship:Ship) -> void:
	var overlay = load("res://Overlays/FlightControl/flight_control_overlay.tscn").instantiate()
	
	overlay.SetShip(ship)
	
	SetActiveOverlay(side, overlay)
	
func ShowGunControlOverlay(side: String, rotationReference, rotationOffset, ship: Ship) -> void:
	var overlay: GunControlOverlay = load("res://Overlays/gun_control_overlay.tscn").instantiate()
	
	overlay.SetShip(ship)
	
	overlay.rotationReference = rotationReference
	overlay.rotationOffset = rotationOffset
	
	SetActiveOverlay(side, overlay)
