extends Area2D

var numberOfReachCollidersColliding: int = 0

func _ready() -> void:
	area_entered.connect(AreaEntered)
	area_exited.connect(AreaExited)

func AreaEntered(area: Area2D) -> void:
	if not area.name == "ReachCollider":
		return
		
	numberOfReachCollidersColliding += 1
	
	ToggleLabelDisplay()

func AreaExited(area: Area2D) -> void:
	if not area.name == "ReachCollider":
		return
	
	numberOfReachCollidersColliding -= 1
	
	ToggleLabelDisplay()

func ToggleLabelDisplay() -> void:
	if numberOfReachCollidersColliding > 0:
		$"../PanelContainer".show()
	else:
		$"../PanelContainer".hide()
	
