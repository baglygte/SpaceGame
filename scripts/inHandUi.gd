extends MarginContainer
class_name InHandUi

func SetInHandItem(itemToSet) -> void:
	$Label.text = "holding"

func ClearInHandItem() -> void:
	$Label.text = "empty"
