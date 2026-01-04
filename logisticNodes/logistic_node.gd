# Contains some items that can be taken by the player
# Propagates its contents to connected nodes

class_name LogisticNode
extends Node2D

var itemType
var store = []
var storeInputIndex = 0
var storeOutputIndex = 0

var pushTo: LogisticNode
var pushToFinal: LogisticNode
var pushDistance = INF

var pullFrom: LogisticNode
var pullFromFinal: LogisticNode
var pullDistance = INF
var connections: Array[LogisticNode] = []

func PropagatePullRequest() -> void:
	for i in connections.size():
		var target = connections[i]
		if target == null:
			continue
		if (target.pullFromFinal != pullFromFinal) || (target.pullDistance>pullDistance+1):
			target.pullFrom = self
			target.pullFromFinal = pullFromFinal
			target.pullDistance = pullDistance + 1
		if (target.pullFromFinal == pullFromFinal) && (target.pullDistance == pullDistance + 1):
			target.PullItem()

func PropagatePushRequest():
	for i in connections.size():
		var target = connections[i]
		if target == null:
			continue
		if (target.pushToFinal != pushToFinal) || (target.pushDistance>pushDistance+1):
			target.pushTo = self
			target.pushToFinal = pushToFinal
			target.pushDistance = pushDistance + 1
		if (target.pushToFinal == pushToFinal) && (target.pushDistance == pushDistance + 1):
			target.PushItem()

func PushItem() -> void:
	if pushTo == null:
		return
		
	if _CanPushItem():
		pushTo.StoreItem(store[storeOutputIndex])
		store[storeOutputIndex] = null
		IncrementOutputIndex()
		pushTo.PushItem()
		if pushTo != null:
			if pushTo.pushDistance == 0:
				pushTo.pushDistance = INF
				
		pushTo = null
		pushToFinal = null
		pushDistance = INF
	else:
		PropagatePushRequest()

func _CanPushItem() -> bool:
	var hasItemToGive = store[storeOutputIndex] != null
	var hasPlaceToPutItem = pushTo.store[pushTo.storeInputIndex] == null
	return hasItemToGive && hasPlaceToPutItem

func _CanPullItem() -> bool:
	var hasItemToTake = pullFrom.store[pullFrom.storeOutputIndex] != null
	var hasPlaceToPutItem = store[storeInputIndex] == null
	return hasPlaceToPutItem && hasItemToTake

func PullItem() -> void:
	if pullFrom == null:
		return
	
	if _CanPullItem():
		StoreItem(pullFrom.store[pullFrom.storeOutputIndex])
		
		pullFrom.store[pullFrom.storeOutputIndex] = null
		
		pullFrom.PushItem()
		
		if pullFrom != null: 
			if pullFrom.pullDistance == 0:
				pullFrom.pullDistance = INF
		pullFrom = null
		pullFromFinal = null
		pullDistance = INF
	else:
		PropagatePullRequest()

func PushAndPull() -> void:
	PushItem()
	PullItem()

func StoreItem(itemToStore):
	store[storeInputIndex] = itemToStore
	storeInputIndex = (storeInputIndex + 1) % store.size()
	
func IncrementOutputIndex():
	storeOutputIndex = (storeOutputIndex + 1) % store.size()
	
func AddConnection(target) -> void:
	var index = connections.find(target)
	
	if index == -1: 
		connections.append(target)
		
	index = target.connections.find(self)
	
	if index == -1: 
		target.connections.append(self)

func RemoveConnection(target) -> void:
	connections.erase(target)
	
	target.connections.erase(self)

func AddItem(item) -> bool:
	if store[storeInputIndex] != null:
		pullFrom = null
		
		pullFromFinal = self
		
		pullDistance = 0
		
		PropagatePullRequest()
		
		return false
		
	StoreItem(item)
	
	if store[storeInputIndex] != null:
		pullFrom = null
		
		pullFromFinal = self
		
		pullDistance = 0
		
		PropagatePullRequest()
		
	PushAndPull()
	
	return true

func RemoveItem() -> Node:
	pushDistance = 0
	
	pushTo = null
	
	pushToFinal = self
	
	PropagatePushRequest()
	
	if store[storeOutputIndex] == null:
		return store[storeOutputIndex]
		
	var item = store[storeOutputIndex]
	
	store[storeOutputIndex] = null
	
	IncrementOutputIndex()
	
	PushAndPull()
	
	return item
