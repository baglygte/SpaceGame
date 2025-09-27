class_name Health
extends Node2D

var maxHealth
var healthAmount = 0

func LoseHealth(amountToLose: int) -> void:
	healthAmount -= amountToLose
	
	if healthAmount < 1:
		if get_parent().has_method("OnDeath"):
			get_parent().OnDeath()
			
		get_parent().queue_free()

func GainHealth(amountToGain: int) -> void:
	var newHealthAmount = healthAmount + amountToGain
	
	if newHealthAmount > maxHealth:
		newHealthAmount = maxHealth
		
	healthAmount  = newHealthAmount
