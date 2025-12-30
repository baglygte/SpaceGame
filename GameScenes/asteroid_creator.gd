class_name AsteroidCreator
extends Node

func _ready() -> void:
	var spawnRange = 5000.0
	
	var asteroidResource = load("res://asteroid.tscn")
	
	var generator = RandomNumberGenerator.new()
	
	var asteroid
	
	for i in range(10):
		asteroid = asteroidResource.instantiate()
		
		asteroid.position.x = generator.randf_range(-spawnRange, spawnRange)
		
		asteroid.position.y = generator.randf_range(-spawnRange, spawnRange)
		
		$"../GameWorld".add_child(asteroid)
		
		
