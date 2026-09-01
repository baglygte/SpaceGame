class_name HealthBar
extends Control

func UpdateHealthBar(healthPercentage: float) -> void:
	print(healthPercentage)
	$Foreground.scale.x = healthPercentage
