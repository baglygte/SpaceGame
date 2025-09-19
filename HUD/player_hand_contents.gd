extends HBoxContainer
class_name PlayerHandContents

func AddItem(hand: String, item) -> void:
	var labelText
	
	if item == null:
		labelText = "empty"
	else:
		labelText = item.name
		
	if hand == "LeftHand":
		$LeftHand/Label.text = labelText
	
	if hand == "RightHand":
		$RightHand/Label.text = labelText
