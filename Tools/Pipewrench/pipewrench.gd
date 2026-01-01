class_name Pipewrench
extends Tool

var playerReach: PlayerReach
var signalerToLink: Node2D
var line: Line2D
var ship
const lineScene = preload("res://Tools/Pipewrench/line_2d.tscn")
	
func _process(_delta: float) -> void:
	if line == null:
		return
		
	line.set_point_position(0, global_position)
		
func _ready() -> void:
	playerReach = get_parent().get_parent().get_node("PlayerReach")
	hoverName = "Pipewrench"
	ship = get_tree().get_first_node_in_group("Ship")
	
func Equip() -> void:
	playerReach.AddHoverGroup("PipewrenchCanEdit")

func Unequip() -> void:
	playerReach.RemoveHoverGroup("PipewrenchCanEdit")
	
func Use() -> void:
	var systemInReach = playerReach.GetNearestItemInGroup("PipewrenchCanEdit")
	
	if systemInReach == null or systemInReach == signalerToLink:
		if line != null:
			line.queue_free()
			line = null
		signalerToLink = null
		return
		
	if signalerToLink == null:
		signalerToLink = systemInReach
		line = lineScene.instantiate()
		ship.add_child(line)
		line.add_point(position)
		line.add_point(signalerToLink.position)
	else:
		EstablishLink(systemInReach)
	
func EstablishLink(item) -> void:		
	var systemA = signalerToLink.get_node("SignalHybrid")
	var systemB = item.get_node("SignalHybrid")
	
	systemA.AddConnection(systemB)
	systemB.AddConnection(systemA)
	
	if not line == null:
		line.queue_free()
	
	signalerToLink = null
