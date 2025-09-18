extends Node2D
class_name PlayerCreator

const player = preload("res://player/player.tscn")

func CreateNewPlayers() -> void:
	var numberOfListeners = get_tree().get_nodes_in_group("PlayerInputListeners").size()
	
	for playerNum in range(numberOfListeners):
		FindAndAssignListener(player.instantiate())
	
func CreateFromSave(variablesToSet: Dictionary) -> void:
	var instance: Player = player.instantiate()

	FindAndAssignListener(instance)
	
	instance.position.x = variablesToSet["position.x"]
	instance.position.y = variablesToSet["position.y"]

func FindAndAssignListener(playerInstance: Player) -> void:
	var listeners = get_tree().get_nodes_in_group("PlayerInputListeners")
	for listener: PlayerInputListener in listeners:
		
		if listener.isAssigned:
			continue
		
		listener.AssignToPlayer(playerInstance)
		get_parent().AddNodeToShip(playerInstance)
		return
