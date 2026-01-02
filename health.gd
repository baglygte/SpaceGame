class_name Health
extends Node

@export var maxHealth: int
var healthAmount = 0

func _ready():
	GainHealth(maxHealth)
	
func LoseHealth(amountToLose: int) -> void:
	healthAmount -= amountToLose
	
	if healthAmount < 1:
		if get_parent().has_method("Kill"):
			get_parent().Kill()

func GainHealth(amountToGain: int) -> void:
	var newHealthAmount = healthAmount + amountToGain
	
	if newHealthAmount > maxHealth:
		newHealthAmount = maxHealth
		
	healthAmount  = newHealthAmount
