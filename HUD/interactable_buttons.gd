class_name InteractableButtons
extends Control

var buttons: Dictionary
var buttonElement = preload("res://HUD/interactableButtonElement.tscn")

func SetElement(button: String, textToDisplay: String):
	RemoveElement(button)
	
	var element = buttonElement.instantiate()
	
	element.get_node("HBoxContainer/Label").text = textToDisplay
	
	element.get_node("HBoxContainer/TextureRect").texture = load(GetTexturePath(button))
	
	buttons[button] = element
	
	$VBoxContainer.add_child(element)

func RemoveElement(button: String):
	if button in buttons.keys():
		buttons[button].queue_free()
		buttons.erase(button)

func GetTexturePath(button: String) -> String:
	match button:
		"Y":
			return "res://Sprites/UI/buttons/button_Y.png"
		"RB":
			return "res://Sprites/UI/buttons/button_RB.png"
	
	return "unknown button"
