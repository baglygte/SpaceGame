class_name FlightControl
extends Node2D

var globalId: int
var ship: Ship

var isOverlayingSectorMap := false

func _ready() -> void:
	SetShip(get_tree().get_first_node_in_group("Ship"))
	
func SetShip(shipToSet: Ship) -> void:
	ship = shipToSet

func ReceiveEnterExit(player: Player) -> void:
	var playerHuds: PlayerHuds = get_tree().get_first_node_in_group("PlayerHuds")
	
	if isOverlayingSectorMap:
		playerHuds.ClearHud(player.viewSide)
	else:
		playerHuds.ShowFlightControlOverlay(player.viewSide)
		
	isOverlayingSectorMap = !isOverlayingSectorMap
	
func ReceiveMovement(movementVector: Vector2) -> void:
	if movementVector.length() == 0:
		return
	
	for thruster: Thruster in ship.assignedThrusters:
		var forceToApply = thruster.GetThrustMoveContribution(self, movementVector)
		
		forceToApply = forceToApply.rotated(ship.rotation)
		
		ship.apply_force(forceToApply, thruster.position)

func ReceiveLook(lookVector: Vector2) -> void:
	if lookVector.length() == 0:
		return

	ship.apply_torque(lookVector.x * 10000)
	
	for thruster: Thruster in ship.assignedThrusters:
		var _forceToApply = thruster.GetThrustLookContribution(lookVector.x, ship)
		#ship.apply_force(forceToApply, thruster.position)
	

	
func GetSaveData() -> Dictionary:
	var dictionaryToSave: Dictionary
	
	dictionaryToSave["systemType"] = "flightcontrol"
	var section: Section = get_parent().get_parent()
	dictionaryToSave["position.x"] = position.x + section.position.x
	dictionaryToSave["position.y"] = position.y + section.position.y
	dictionaryToSave["rotation"] = rotation
	dictionaryToSave["globalId"] = globalId
	
	return dictionaryToSave
