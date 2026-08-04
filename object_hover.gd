class_name ObjectHover
extends Node

func IsValidHover(hoverFilter) -> bool:
	for child: HoverGroup in get_children():
		if child.hoverName == hoverFilter:
			return true
	
	return false

func SendInteractableButtonsToHUD(interactableButtons: InteractableButtons, hoverFilter):
	for hoverGroup: HoverGroup in get_children():
		if not hoverGroup.hoverName == hoverFilter:
			continue
			
		for i in hoverGroup.buttons.size():
			interactableButtons.SetElement(hoverGroup.buttons[i], hoverGroup.buttonDescriptions[i])
			
		return

func RemoveButtonsFromHUD(interactableButtons: InteractableButtons):
	for child: HoverGroup in get_children():		
		for button in child.buttons:
			interactableButtons.RemoveElement(button)
