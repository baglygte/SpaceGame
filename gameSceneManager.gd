extends Node
class_name GameSceneManager
var activeScene
var destinationScene: String # Go to this scene after assigning device(s)
var persistentData: Dictionary

func _ready() -> void:
	call_deferred("ChangeActiveScene", "res://GameScenes/mainMenu.tscn")

func ChangeActiveScene(scenePath: String) -> void:
	var scene = load(scenePath).instantiate()
	
	if activeScene != null:
		activeScene.queue_free()
	
	activeScene = scene
	
	get_parent().add_child(scene)

func SetDestinationScene(path: String) -> void:
	destinationScene = path

func GoToDestinationScene() -> void:
	ChangeActiveScene(destinationScene)

func AddPersistentChild(node: Node) -> void:
	get_parent().add_child(node)

func AddPersistentData(data: Dictionary) -> void:
	persistentData.merge(data, true)

func RemovePersistentData(key: String) -> void:
	if !persistentData.has(key):
		return
	
	persistentData.erase(key)
