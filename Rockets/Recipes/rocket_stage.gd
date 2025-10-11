class_name RocketStage
extends Node2D
var Name = "Stage"
var isHoming = false
var acceleration: Vector2
var time = 1
var children = 0
var childrecipe = null
var velocityTerminal = 50
var velocityAcceleration = 250000
var velocityTurning = 0.05
var startSpread = -PI/4
var deltaSpread = PI/8
var collisionDisabled = false
