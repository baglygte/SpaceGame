class_name PlayerHandContents
extends Control

func AddItem(hand: String, itemTexture: Texture) -> void:
	if hand == "OffHand":
		$HBoxContainer/OffHand/HeldTool.texture = itemTexture
	
	if hand == "MainHand":
		$HBoxContainer/MainHand/HeldItem.texture = itemTexture

func RemoveItem(hand: String) -> void:
	if hand == "OffHand":
		$HBoxContainer/OffHand/HeldTool.texture = null
	
	if hand == "MainHand":
		$HBoxContainer/MainHand/HeldItem.texture = null
