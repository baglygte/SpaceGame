extends Node2D
var globalId: int

const rocketScene = preload("res://rocket.tscn")
func ReceiveMovement(vector: Vector2) -> void:
	$Barrel.rotate(deg_to_rad(3) * sign(vector.x))

func ReceiveLeftHand() -> void:
	var rocket: RigidBody2D = rocketScene.instantiate()
	rocket.rotation = $Barrel.rotation
	rocket.global_position = global_position
	var gameScene = get_tree().root.get_child(0).get_node("Game")
	gameScene.add_child(rocket)
	rocket.apply_central_force(Vector2.UP.rotated($Barrel.rotation) * 10000)

func GetSaveData() -> Dictionary:
	var dictionaryToSave: Dictionary = {"creator": "SystemBuilder"}
	
	dictionaryToSave["systemType"] = "gun"
	dictionaryToSave["position.x"] = position.x
	dictionaryToSave["position.y"] = position.y
	dictionaryToSave["rotation"] = rotation
	dictionaryToSave["globalId"] = globalId
	
	return dictionaryToSave
