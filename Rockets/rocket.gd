extends RigidBody2D
var recipe: RocketRecipe = null
var stage: RocketStage = null
var stageCounter = -1
var homingTarget = null
var acceleration: Vector2
var isHoming = false
var velocityTerminal = 100
var velocityAcceleration = 1000
var velocityTurning = 5
var startSpread = -PI/4
var deltaSpread = PI/8
const rocketScene = preload("res://Rockets/rocket.tscn")
var oldRot = 0
var oldPos: Vector2

func _ready() -> void:
	$Health.maxHealth = 1
	$Health.GainHealth(1)
	$CollisionShape2D.disabled = true
	$StarmapBlipConnector.Initialize("EnemyRocket")
	$Timer.timeout.connect(NextStage)
	$Timer.start(0.0001)

func _process(delta: float) -> void:
	linear_damp = delta*velocityTerminal
	if isHoming && homingTarget!=null:
		var vectorToTarget: Vector2 = homingTarget.position - position
		var angleToTarget = PI/2 + vectorToTarget.angle() - rotation
		if(angleToTarget>PI): angleToTarget -= 2*PI
		apply_torque(10000*delta*angleToTarget)
	acceleration = Vector2.UP.rotated(rotation) * velocityAcceleration
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
		var gameScene = get_node("/root/MasterScene/Game/GameWorld")
		for i in stage.children:
			var rocket: Node2D = rocketScene.instantiate()
			rocket.rotation = rotation + stage.startSpread + i * stage.deltaSpread
			rocket.global_position = global_position
			rocket.apply_central_force(acceleration)
			rocket.recipe = stage.childrecipe
			rocket.homingTarget = homingTarget
			gameScene.add_child(rocket)
