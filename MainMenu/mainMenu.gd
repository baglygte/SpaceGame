extends Node2D

func AddConnectedPlayerPanel(instance) -> void:
	$Margin/HBoxContainer.add_child(instance)
	
