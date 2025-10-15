class_name LogisticNode
extends Node2D
var itemType
var store = []
var storeInputIndex = 0
var storeOutputIndex = 0
var giveTo
var giveToFinal
var giveDistance = INF
var takeFrom
var takeFromFinal
var takeDistance = INF
var time = 0
var connections = []
var item

func Propagate(giveortake: bool) -> void:
	for i in connections.size():
		var target = connections[i]
		if target == null:
			continue
		if giveortake:
			if (target.giveToFinal != giveToFinal) || (target.giveDistance>giveDistance+1):
				target.giveTo = self
				target.giveToFinal = giveToFinal
				target.giveDistance = giveDistance + 1
			if (target.giveToFinal == giveToFinal) && (target.giveDistance == giveDistance + 1):
				target.ActivateGive()
		else:
			if (target.takeFromFinal != takeFromFinal) || (target.takeDistance>takeDistance+1):
				target.takeFrom = self
				target.takeFromFinal = takeFromFinal
				target.takeDistance = takeDistance + 1
			if (target.takeFromFinal == takeFromFinal) && (target.takeDistance == takeDistance + 1):
				target.ActivateTake()
	$Timer.start(time)

func ActivateGive() -> void:
	if giveTo != null:
		if (store[storeOutputIndex] != null) && (giveTo.store[giveTo.storeInputIndex] == null):
			giveTo.store[giveTo.storeInputIndex] = store[storeOutputIndex]
			giveTo.storeInputIndex = (giveTo.storeInputIndex + 1) % giveTo.store.size()
			store[storeOutputIndex] = null
			storeOutputIndex = (storeOutputIndex + 1) % store.size()
			giveTo.ActivateGive()
			if giveTo != null:  if giveTo.giveDistance == 0: giveTo.giveDistance = INF
			giveTo = null
			giveToFinal = null
			giveDistance = INF
		else:
			Propagate(true)

func ActivateTake() -> void:
	if takeFrom != null:
		if (store[storeInputIndex] == null) && (takeFrom.store[takeFrom.storeOutputIndex] != null):
			store[storeInputIndex] = takeFrom.store[takeFrom.storeOutputIndex]
			storeInputIndex = (storeInputIndex + 1) % store.size()
			takeFrom.store[takeFrom.storeOutputIndex] = null
			takeFrom.storeOutputIndex = (takeFrom.storeOutputIndex + 1) % takeFrom.store.size()
			takeFrom.ActivateGive()
			if takeFrom != null:  if takeFrom.takeDistance == 0: takeFrom.takeDistance = INF
			takeFrom = null
			takeFromFinal = null
			takeDistance = INF
		else:
			Propagate(false)

func Activate() -> void:
	ActivateGive()
	ActivateTake()

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

func AddItem(Item) -> bool:
	if store[storeInputIndex] != null:
		takeFrom = null
		takeFromFinal = self
		takeDistance = 0
		Propagate(false)
		return false
	store[storeInputIndex] = Item
	storeInputIndex = (storeInputIndex + 1) % store.size()
	if store[storeInputIndex] != null:
		takeFrom = null
		takeFromFinal = self
		takeDistance = 0
		Propagate(false)
	Activate()
	return true

func RemoveItem() -> bool:
	giveDistance = 0
	giveTo = null
	giveToFinal = self
	Propagate(true)
	if store[storeOutputIndex] == null:
		item = null
		return false
	item = store[storeOutputIndex]
	store[storeOutputIndex] = null
	storeOutputIndex = (storeOutputIndex + 1) % store.size()
	Activate()
	return true
