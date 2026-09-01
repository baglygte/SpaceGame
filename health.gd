class_name Health
extends Node

@export var maxHealth: int = 1
@export var startingHealth: int = maxHealth
@export var healthBar: HealthBar

var _currentHealth: float = 0

func _ready():
	GainHealth(startingHealth)
	
func LoseHealth(amountToLose: int) -> void:
	_currentHealth -= amountToLose
	
	if _currentHealth < 0:
		_currentHealth = 0
	
	if _currentHealth == 0:
		if get_parent().has_method("Kill"):
			get_parent().Kill()
			
	EmitHealthChanged()

func GainHealth(amountToGain: int) -> void:
	var newcurrentHealth = _currentHealth + amountToGain
	
	if newcurrentHealth > maxHealth:
		newcurrentHealth = maxHealth
		
	_currentHealth  = newcurrentHealth
	
	EmitHealthChanged()

func EmitHealthChanged() -> void:
	if healthBar == null:
		return
		
	healthBar.UpdateHealthBar(_currentHealth/maxHealth)
	
