extends VBoxContainer

var connectedDeviceIds: Dictionary

const connectDevicePanel = preload("res://menu/connectedDevicePanel.tscn")

func _process(_delta: float) -> void:
	var detectedDeviceIds = Input.get_connected_joypads()
	
	GetDevicesToRemove(detectedDeviceIds)

	GetDevicesToAdd(detectedDeviceIds)
	
func GetDevicesToRemove(detectedDeviceIds) -> void:
	for connectedDeviceId in connectedDeviceIds.keys():
		if connectedDeviceId in detectedDeviceIds:
			continue
		RemoveConnectedDevice(connectedDeviceId)

func GetDevicesToAdd(detectedDeviceIds) -> void:
	for detectedDeviceId in detectedDeviceIds:
		if detectedDeviceId in connectedDeviceIds.keys():
			continue
		AddConnectedDevice(detectedDeviceId)
		
func AddConnectedDevice(deviceId) -> void:
	var panel: ConnectedDevicePanel = connectDevicePanel.instantiate()
	panel.SetLabelText(str(deviceId))
	$HBoxContainer.add_child(panel)
	connectedDeviceIds[deviceId] = panel
	
func RemoveConnectedDevice(deviceId) -> void:
	if not deviceId in connectedDeviceIds.keys():
		return
		
	connectedDeviceIds[deviceId].queue_free()
	
	connectedDeviceIds.erase(deviceId)
