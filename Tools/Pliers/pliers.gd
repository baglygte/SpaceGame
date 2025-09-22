extends Node2D
class_name Pliers

var playerReach: PlayerReach
var signalerToLink

func _ready() -> void:
	playerReach = get_parent().get_parent().get_node("PlayerReach")
	
func Equip() -> void:
	playerReach.AddHoverGroup("PliersCanEdit")

func Unequip() -> void:
	playerReach.RemoveHoverGroup("PliersCanEdit")
	
func Use() -> void:
	var item = playerReach.GetNearestItemInGroup("PliersCanEdit")
	
	if item == null:
		return
	
	if signalerToLink == null:
		signalerToLink = GetSignaler(item)
	else:
		EstablishLink(GetSignaler(item))
		
func GetSignaler(item: Node2D) -> Node2D:
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
