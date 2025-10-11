class_name Pipewrench
extends Tool

var playerReach: PlayerReach
var signalerToLink: Node2D
var line: Line2D
const lineScene = preload("res://Tools/Pipewrench/line_2d.tscn")
	
func _process(_delta: float) -> void:
	if line == null:
		return
		
	line.set_point_position(0, global_position)
		
func _ready() -> void:
	playerReach = get_parent().get_parent().get_node("PlayerReach")
	hoverName = "Pipewrench"
	
func Equip() -> void:
	hide()
	playerReach.AddHoverGroup("PipewrenchCanEdit")

func Unequip() -> void:
	show()
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
		
		if signalerToLink != null:
			line = lineScene.instantiate()
			var ship = get_tree().get_first_node_in_group("Ship")
			ship.add_child(line)
			line.add_point(position)
			line.add_point(signalerToLink.global_position + ship.position)
	else:
		EstablishLink(systemInReach)
	
func EstablishLink(item) -> void:	
	var builder: ConnectionBuilder = get_tree().get_first_node_in_group("Ship").get_node("ConnectionBuilder")
	builder.ConnectSystems(item, signalerToLink)
	
	if not line == null:
		line.queue_free()
	
	signalerToLink = null
