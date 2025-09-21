class_name Tool
extends Node

var isEquipped: bool = false
func _process(_delta: float) -> void:
	if !isEquipped:
		return
	get_child(0).OnProcess()
	
func Equip() -> void:
	isEquipped = true
	get_child(0).OnEquip()

func Unequip() -> void:
	isEquipped = false
	get_child(0).OnUnequip()

func Use() -> void:
	if isEquipped == false:
		return
	
	get_child(0).OnUse()
