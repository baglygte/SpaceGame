extends RigidBody2D
var recipe: RocketRecipe = null
var stage: RocketStage = null
var stageCounter = -1
var homingTarget = null
var acceleration: Vector2
var Rotation
var children = 0
var isHoming = false
var velocityTerminal = 100
var velocityAcceleration = 1000
var velocityTurning = 5
var startSpread = -PI/4
var deltaSpread = PI/8
const rocketScene = preload("res://Rockets/rocket.tscn")


func _ready() -> void:
	$Health.maxHealth = 1
	$Health.GainHealth(1)
	Rotation = rotation
	$CollisionShape2D.disabled = true
	$StarmapBlipConnector.Initialize("EnemyRocket")
	$Timer.timeout.connect(NextStage)
	$Timer.start(0.00001)

func _process(delta: float) -> void:
	linear_damp = delta*velocityTerminal
	if isHoming && homingTarget!=null:
		var vectorToTarget: Vector2 = homingTarget.position - position
		var angleToTarget = PI/2 + vectorToTarget.angle() - Rotation
		if(angleToTarget>PI): angleToTarget -= 2*PI
		angleToTarget = max(min(angleToTarget,velocityTurning),-velocityTurning)
		Rotation += delta*angleToTarget
	acceleration = Vector2.UP.rotated(Rotation) * velocityAcceleration
	rotation = Rotation
	apply_central_force(delta*acceleration)
	
func Kill() -> void:
	$StarmapBlipConnector.Kill()
	var soundSystem = get_tree().get_first_node_in_group("SoundSystem")
	soundSystem.PlaySoundAtPosition("res://Audio/explosion.wav", global_position)
	queue_free()

func NextStage() -> void:
	if recipe == null: return
	if stageCounter>=0: SpawnChildren()
	stageCounter += 1
	if stageCounter>=recipe.stages.size():
		Kill()
		return
	stage = recipe.stages[stageCounter]
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
