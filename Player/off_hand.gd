class_name OffHand
extends Node2D

var heldTool: Tool

func SetHeldTool(tool: Tool):
	if heldTool != null:
		heldTool.Unequip()
		remove_child(heldTool)

	heldTool = tool
	add_child(tool)
	tool.Equip()
	
	UpdateHud()

func UseHeldTool():
	if heldTool == null:
		return
	
	heldTool.Use()

func UpdateHud() -> void:
	var playerHuds: PlayerHuds = get_tree().get_first_node_in_group("PlayerHuds")
	playerHuds.AddItemToHands(get_parent(), name, heldTool.get_node("Sprite2D").texture)

func GetToolHoverFilter() -> String:
	if heldTool == null:
		return "Hands"

	return heldTool.hoverName
