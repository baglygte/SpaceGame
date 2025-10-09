@abstract
class_name Tool
extends Node2D

var isEquipped: bool = false
var player: Player
var mainHand: MainHand

@abstract func Equip()
@abstract func Unequip()
