extends Node2D
var hud
var isActive = false
var selfText
var connectionText
var connectiontext
var storeText
var storetext
var signalTakeText
var signalTaketext
var signalGiveText
var signalGivetext

func _process(_delta: float) -> void:
	if not isActive: return
	var connections = get_parent().connections
	connectiontext = "Connections: "
	for i in connections.size():
		connectiontext = connectiontext + ", " + str(connections[i]).substr(20,10)
	connectionText.text = connectiontext
	var store = get_parent().store
	storetext = "Stored: (input index) " + str(get_parent().storeInputIndex) + ", (output index) " + str(get_parent().storeOutputIndex)
	for i in store.size():
		storetext = storetext + ", "
		if store[i] != null: 
			storetext = storetext + str(store[i].Name)
	storeText.text = storetext
	signalTaketext = "Take From: Dist: " + str(get_parent().takeDistance)
	if get_parent().takeFrom != null:
		signalTaketext = signalTaketext + ", " + str(get_parent().takeFrom).substr(20,10)
	signalTakeText.text = signalTaketext
	signalGivetext = "Give To: Dist: " + str(get_parent().giveDistance)
	if get_parent().giveTo != null:
		signalGivetext = signalGivetext + ", " + str(get_parent().giveTo).substr(20,10)
	signalGiveText.text = signalGivetext
	
	
	

func DrawHUD() -> void:
	hud = get_node("/root/MasterScene/Game/HUD")
	selfText = Label.new()
	selfText.position.x = 50
	selfText.position.y = 50
	selfText.text = "Own ID: " + str(get_parent()).substr(20,10) + "     RT: Add Rocket, LT: Remove Rocket"
	connectionText = Label.new()
	connectionText.position.x = 50
	connectionText.position.y = 90
	storeText = Label.new()
	storeText.position.x = 50
	storeText.position.y = 130
	signalTakeText = Label.new()
	signalTakeText.position.x = 50
	signalTakeText.position.y = 170
	signalGiveText = Label.new()
	signalGiveText.position.x = 50
	signalGiveText.position.y = 210
	isActive = true
	hud.add_child(selfText)
	hud.add_child(connectionText)
	hud.add_child(storeText)
	hud.add_child(signalTakeText)
	hud.add_child(signalGiveText)

func eraseHUD() -> void:
	hud = get_node("/root/MasterScene/Game/HUD")
	hud.remove_child(selfText)
	hud.remove_child(connectionText)
	hud.remove_child(storeText)
	hud.remove_child(signalTakeText)
	hud.remove_child(signalGiveText)
	isActive = false
