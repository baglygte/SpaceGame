extends Area2D
# A collider that detects if a player is in contact
# and emits a signal if the interact key is pressed

signal interactedWithSignal
var player: Player

func _init() -> void:
	body_entered.connect(EnteredRegion)
	body_exited.connect(LeftRegion)

func EnteredRegion(body: Node2D) -> void:
	if body is not Player:
		return
		
	player = body
	
func LeftRegion(_body: Node2D) -> void:
	player = null

func InteractedWith() -> void:
	if player == null:
		return
	
	interactedWithSignal.emit(player)
