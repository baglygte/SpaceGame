class_name RocketStage
extends Node2D
var Name = "Stage"
var isHoming = false
var acceleration: Vector2
var time = 1
var children = 0
var childrecipe = null
var velocityTerminal = 100
var velocityAcceleration = 500000
var velocityTurning = 50
var startSpread = -PI/4
var deltaSpread = PI/8
var collisionDisabled = false
