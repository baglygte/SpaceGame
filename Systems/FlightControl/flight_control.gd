class_name FlightControl
extends Node2D

var globalId: int
var ship: Ship

var isOverlayingSectorMap := false

func _ready() -> void:
	ship = get_tree().get_first_node_in_group("Ship")

func ReceiveEnterExit(player: Player) -> void:
	var viewPorts: PlayerViewPorts = get_tree().get_first_node_in_group("PlayerViewPorts")
	
	if isOverlayingSectorMap:
		var gameWorld = get_tree().get_first_node_in_group("GameWorld")
		viewPorts.SwitchToSubView(gameWorld, player.viewSide)
		isOverlayingSectorMap = false
	else:
		var sectorMapOverlay = get_tree().get_first_node_in_group("SectorMapOverlay")
		viewPorts.SwitchToSubView(sectorMapOverlay, player.viewSide)
		isOverlayingSectorMap = true
	
	
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
		
	for thruster: Thruster in ship.assignedThrusters:
		var forceToApply = thruster.GetThrustLookContribution(lookVector.x, ship)
		ship.apply_force(forceToApply, thruster.position)
	
func GetSaveData() -> Dictionary:
	var dictionaryToSave: Dictionary = {"creator": "InternalSystemBuilder"}
	
	dictionaryToSave["systemType"] = "flightcontrol"
	var section: Section = get_parent().get_parent()
	dictionaryToSave["position.x"] = position.x + section.position.x
	dictionaryToSave["position.y"] = position.y + section.position.y
	dictionaryToSave["rotation"] = rotation
	dictionaryToSave["globalId"] = globalId
	
	return dictionaryToSave
