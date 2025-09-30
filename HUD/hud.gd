extends Control
class_name HUD

var playerHandSets: Dictionary

func CreatePlayerHands(playerInstance: Player) -> void:
	
	var instance: PlayerHandContents = preload("res://HUD/player_hand_contents.tscn").instantiate()
	playerHandSets[playerInstance] = instance
	
	if playerHandSets.size() == 1:
		$PlayerViewports/SubViewportContainerLeft.add_child.call_deferred(instance)
	elif playerHandSets.size() == 2:
		$PlayerViewports/SubViewportContainerRight.add_child.call_deferred(instance)

func AddItemToHands(instance: Player, hand, item) -> void:
	playerHandSets[instance].AddItem(hand, item)

func _process(_delta: float) -> void:
	var ship = get_tree().get_first_node_in_group("Ship")
	
	if ship == null:
		return
	
	var xText = "x: " + str(round(ship.position.x / 100))
	var yText = "y: " + str(round(ship.position.y / 100))
	
	$CenterContainer/HBoxContainer/VBoxContainer/xCoorLabel.text = xText
	$CenterContainer/HBoxContainer/VBoxContainer/yCoorLabel.text = yText
	
	$CenterContainer/HBoxContainer/Control/Sprite2D.rotation = ship.rotation
