extends Node2D
class_name Pliers

var playerReach: PlayerReach
var signalerToLink: Node2D
var line: Line2D
const lineScene = preload("res://Tools/Pliers/line_2d.tscn")
	
func _process(_delta: float) -> void:
	if line == null:
		return
		
	line.set_point_position(0, global_position)
	#queue_redraw()
		
func _ready() -> void:
	playerReach = get_parent().get_parent().get_node("PlayerReach")
	
func Equip() -> void:
	playerReach.AddHoverGroup("PliersCanEdit")

func Unequip() -> void:
	playerReach.RemoveHoverGroup("PliersCanEdit")
	
func Use() -> void:
	var item = playerReach.GetNearestItemInGroup("PliersCanEdit")
		
	var signalerInReach = GetSignaler(item)
	
	if item == null or signalerInReach == signalerToLink:
		if line != null:
			line.queue_free()
			line = null
		signalerToLink = null
		return
		
	if signalerToLink == null:
		signalerToLink = GetSignaler(item)
		
		if signalerToLink != null:
			line = lineScene.instantiate()
			get_tree().root.get_child(0).get_node("Game").add_child(line)
			line.add_point(global_position)
			line.add_point(signalerToLink.get_parent().global_position)
	else:
		EstablishLink(GetSignaler(item))
	
func GetSignaler(item: Node2D) -> Node2D:
	if item == null:
		return null
		
	var children = item.get_children()
	
	for child in children:
		if child.is_in_group("signaler"):
			return child
		
	return null
	
func EstablishLink(item) -> void:
	if signalerToLink is SignalEmitter:
		signalerToLink.AddReceiver(item)
		print("Linked " + item.get_parent().name + " to " + signalerToLink.get_parent().name)
	
	if item is SignalEmitter:
		item.AddReceiver(signalerToLink)
		print("Linked " + item.get_parent().name + " to " + signalerToLink.get_parent().name)
	
	if not line == null:
		line.queue_free()
	
	signalerToLink = null
