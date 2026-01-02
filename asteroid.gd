class_name Asteroid
extends RigidBody2D

func _ready() -> void:
	$StarmapBlipConnector.Initialize("Neutral")

func Kill():
	$StarmapBlipConnector.Kill()
	
	var creator: ContainedItemCreator = get_node("/root/MasterScene/Game/ContainedItemCreator")
	
	creator.SpawnItemInWorld(GetRandomSystem(), position)
	
	queue_free()

func GetRandomSystem() -> Node2D:
	var paths = ["res://Systems/AmmoDepot/ammoDepot.tscn",
		"res://Systems/ControlSeat/controlSeat.tscn",
		"res://Systems/FlightControl/flightControl.tscn",
		"res://Systems/GrabberArm/grabberArm.tscn",
		"res://Systems/Gun/gun.tscn",
		"res://Systems/Thruster/thruster.tscn"]
				
	var rng = RandomNumberGenerator.new()
	var i = rng.randi_range(0,paths.size()-1)

	return load(paths[i]).instantiate()
