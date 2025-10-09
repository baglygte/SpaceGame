class_name PlayerHandContents
extends Control

func AddItem(hand: String, item) -> void:
	var labelText
	
	if item == null:
		labelText = "empty"
	else:
		labelText = item.name
		
	if hand == "OffHand":
		$HBoxContainer/OffHand/Label.text = labelText
	
	if hand == "MainHand":
		$HBoxContainer/MainHand/Label.text = labelText
