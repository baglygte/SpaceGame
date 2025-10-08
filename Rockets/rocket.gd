extends RigidBody2D
var recipe: RocketRecipe = null
var stage: RocketStage = null
var stageCounter = -1
var homingTarget = null
var acceleration: Vector2
var Rotation
var children = 0
var isHoming = false
var velocityTerminal = 1
var velocityAcceleration = 10
var velocityTurning = 0.05
var startSpread = -PI/4
var deltaSpread = PI/8
const rocketScene = preload("res://Rockets/rocket.tscn")


func _ready() -> void:
	$Health.maxHealth = 1
	$Health.GainHealth(1)
	$CollisionShape2D.disabled = true
	Rotation = rotation
	$StarmapBlipConnector.blipType = "EnemyRocket"
	$StarmapBlipConnector.Initialize()
	$Timer.timeout.connect(NextStage)
	$Timer.start(0.00001)

func _process(_delta: float) -> void:
	linear_damp = velocityTerminal
	if isHoming && homingTarget!=null:
		var vectorToTarget: Vector2 = homingTarget.position - position
		var angleToTarget = PI/2 + vectorToTarget.angle() - Rotation
		if(angleToTarget>PI): angleToTarget -= 2*PI
		angleToTarget = max(min(angleToTarget,velocityTurning),-velocityTurning)
		Rotation += angleToTarget
	acceleration = Vector2.UP.rotated(Rotation) * velocityAcceleration
	rotation = Rotation
	apply_central_force(acceleration)
	
func Kill() -> void:
	$StarmapBlipConnector.Kill()
	queue_free()

func NextStage() -> void:
	if recipe == null: return
	if stageCounter>=0: SpawnChildren()
	stageCounter += 1
	match stageCounter:
		0: stage = recipe.stage0
		1: stage = recipe.stage1
		2: stage = recipe.stage2
		3: stage = recipe.stage3
		4: stage = recipe.stage4
		5: stage = null
	if stage==null:
		Kill()
		return
	$Timer.start(stage.time)
	isHoming = stage.isHoming
	velocityTerminal = stage.velocityTerminal
	velocityAcceleration = stage.velocityAcceleration
	velocityTurning = stage.velocityTurning
	$CollisionShape2D.disabled = stage.collisionDisabled

func SpawnChildren() -> void:
	if stage.children > 0:
		var gameScene = get_tree().get_first_node_in_group("GameWorld")
		for i in stage.children:
			var rocket: Node2D = rocketScene.instantiate()
			rocket.rotation = rotation + stage.startSpread + i * stage.deltaSpread
			rocket.global_position = global_position
			rocket.apply_central_force(40*acceleration + Vector2.UP.rotated(rocket.rotation) * 200000)
			rocket.recipe = stage.childrecipe
			rocket.homingTarget = homingTarget
			gameScene.add_child(rocket)
