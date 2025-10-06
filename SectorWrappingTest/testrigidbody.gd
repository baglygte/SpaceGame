extends  RigidBody2D

#var sectorToBankInto
#var newPosition
#var removeAfterTick: bool = false
#
#func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	#if newPosition == null:
		#return
		#
	#state.transform.origin = newPosition
	#newPosition = null
	#print("My position is now: " + str(state.transform.origin))
	#if removeAfterTick:
		#$"..".sectorBank[sectorToBankInto].append(self)
		#queue_free()
		#removeAfterTick = false
