extends CanvasLayer
class_name HUD

var playerHandSets: Dictionary

func CreatePlayerHands(playerInstance: Player) -> void:
	var instance: PlayerHandContents = preload("res://HUD/player_hand_contents.tscn").instantiate()
	playerHandSets[playerInstance] = instance
	
	if $MarginContainer.get_child_count() == 1:
		instance.alignment = BoxContainer.ALIGNMENT_END
		
	$MarginContainer.add_child(instance)

func AddItemToHands(instance: Player, hand, item) -> void:
	playerHandSets[instance].AddItem(hand, item)
