extends Node2D

const recipeScene = preload("res://Rockets/Recipes/rocket_recipe.tscn")
const stageScene = preload("res://Rockets/Recipes/rocket_stage.tscn")
const bodyScene = preload("res://Rockets/Recipes/rocket_body.tscn")

var Recipes: Dictionary
var Stages: Dictionary
var Bodies: Dictionary

func _ready() -> void:
	add_to_group("RocketRecipes")
	var recipe = RecipeInitialize("Child")
	var stage = StageInitialize("ChildS0")
	stage.collisionDisabled = true
	stage.time = 0.5
	recipe.stages.resize(2)
	recipe.stages[0] = stage
	stage = StageInitialize("ChildS1")
	recipe.stages[1] = stage
	stage = StageInitialize("SplitRocketS1")
	stage.isHoming = true
	stage.childrecipe = recipe
	stage.children = 3
	recipe = RecipeInitialize("SplitRocket")
	recipe.isHoming = true
	recipe.stages.resize(2)
	recipe.stages[1] = stage
	stage = StageInitialize("SplitRocketS0")
	recipe.stages[0] = stage

func RecipeInitialize(rname: String) -> RocketRecipe:
	var recipe = recipeScene.instantiate()
	recipe.Name = rname
	Recipes[rname] = recipe
	return recipe

func RecipeRemove(rname: String) -> void:
	Recipes[rname].queue_free()
	Recipes.erase(rname)

func StageInitialize(rname: String) -> RocketStage:
	var stage = stageScene.instantiate()
	stage.Name = rname
	Stages[rname] = stage
	return stage

func StageRemove(rname: String) -> void:
	Stages[rname].queue_free()
	Stages.erase(rname)
