extends Control
class_name HUD

func CreatePlayerHud(player: Player) -> void:
	
	var handContents: PlayerHandContents = preload("res://HUD/player_hand_contents.tscn").instantiate()
	var playerHud
	
	if player.viewSide == "Left":
		playerHud = $PlayerHuds/LeftPlayerHud
	elif player.viewSide == "Right":
		playerHud = $PlayerHuds/RightPlayerHud
	
	playerHud.add_child.call_deferred(handContents)
	$PlayerHuds.playerHandSets[player] = handContents
	
	var toolWheel: ToolWheel = load("res://Player/ToolWheel/tool_wheel.tscn").instantiate()
	toolWheel.player = player
	player.toolWheel = toolWheel
	playerHud.add_child.call_deferred(toolWheel)
