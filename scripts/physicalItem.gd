extends Node2D
# An item "on the ground". An object is contained
# in this item and transferred when the physical
# item is picked up
const rotateSpeed = 2
var containedItem

func _process(delta: float) -> void:
	rotate(rotateSpeed * delta)
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is not Player:
		return
		
	var wasPickedUp = body.playerInventory.PickupItem(containedItem)
	
	if !wasPickedUp:
		return
			
	queue_free() # Delete node

func ContainItem(itemToContain) -> void:
	containedItem = itemToContain
