extends Control
class_name HUD

var playerHandSets: Dictionary

func CreatePlayerHands(playerInstance: Player) -> void:
	
	var instance: PlayerHandContents = preload("res://HUD/player_hand_contents.tscn").instantiate()
	playerHandSets[playerInstance] = instance
	
	if playerHandSets.size() == 1:
		$PlayerViewports/LeftPlayerView.add_child.call_deferred(instance)
	elif playerHandSets.size() == 2:
		$PlayerViewports/RightPlayerView.add_child.call_deferred(instance)

func AddItemToHands(instance: Player, hand, item) -> void:
	playerHandSets[instance].AddItem(hand, item)
