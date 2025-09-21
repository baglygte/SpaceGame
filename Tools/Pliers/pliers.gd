extends Tool
class_name Pliers

var playerReach: PlayerReach

func _ready() -> void:
	playerReach = get_parent().get_parent().get_parent().get_node("PlayerReach")
	
func OnProcess() -> void:		
	return
	
func OnEquip() -> void:
	playerReach.AddHoverGroup("PliersCanEdit")

func OnUnequip() -> void:
	playerReach.RemoveHoverGroup("PliersCanEdit")
	
func OnUse() -> void:
	var items = playerReach.GetItemsInGroup("PliersCanEdit")
	print(items[0].name)
	return
