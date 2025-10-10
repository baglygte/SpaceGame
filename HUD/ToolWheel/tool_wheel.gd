class_name ToolWheel
extends Control

var player: Player
var ship: Ship
@onready var numberOfSlots = get_children().size()

const wheelRadius = 50
const toolSprites: Array = ["res://Sprites/Tools/hammer.png",
							"res://Sprites/Tools/pliers.png",
							"res://Sprites/Tools/wrench.png",
							"res://Sprites/Tools/pipewrench.png"]
							
const toolScenes: Array = ["res://Tools/Hammer/hammer.tscn",
						   "res://Tools/Pliers/pliers.tscn",
						   "res://Tools/Wrench/wrench.tscn",
						   "res://Tools/Pipewrench/pipewrench.tscn"]
func _ready():
	ship = get_tree().get_first_node_in_group("Ship")
	for i in range(0,numberOfSlots):
		var angle: float = 2*PI/numberOfSlots * i
		var child: ToolWheelSlot = get_child(i)
		child.rotation = angle
		child.get_node("Sprite2D").rotation = -angle
		child.hide()
		child.get_child(0).get_child(0).texture = load(toolSprites[i])

func _process(_delta: float) -> void:
	if player == null:
		return
	
	var child
	for i in range(0,numberOfSlots):
		child = get_child(i)
		child.get_node("Sprite2D").frame = 0
		
	var childId = GetSelectedIndex()
	
	get_child(childId).get_node("Sprite2D").frame = 1

func ShowWheel():
	for child in get_children():
		child.show()
		child.get_node("AnimationPlayer").play("appear")

func HideWheel():
	var selectedIndex = GetSelectedIndex()
	var tool = load(toolScenes[selectedIndex]).instantiate()
	player.get_node("OffHand").SetHeldTool(tool)
	for child in get_children():
		child.get_node("AnimationPlayer").play_backwards("appear")

func GetSelectedIndex() -> int:
	var playerRotation = player.rotation + PI/2
	return round(playerRotation * numberOfSlots / 2 / PI)
