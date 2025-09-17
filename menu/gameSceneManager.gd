extends Node

var activeScene

func _ready() -> void:
	ChangeActiveScene("res://menu/mainMenu.tscn")

func ChangeActiveScene(scenePath: String) -> void:
	var scene = load(scenePath).instantiate()
	
	if activeScene != null:
		activeScene.queue_free()
	
	activeScene = scene
	
	scene.gameSceneManager = $"."
	
	get_parent().add_child.call_deferred(scene)
