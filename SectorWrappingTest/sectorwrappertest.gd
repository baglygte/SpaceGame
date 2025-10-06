extends Node2D

const sectorSize: float = 100 # The edge-to-edge span of a sector
# These have to be larger than 3
const hSectors: int = 4
const vSectors: int = 4

var globalSector: Vector2i # The unwrapped sector the player is in
var sectorBank: Dictionary # Contains nodes for all inactive sectors

const sectorDeltas = [Vector2i(-1,-1), Vector2i(0,-1), Vector2i(1,-1),
					 Vector2i(-1,0), Vector2i(0,0), Vector2i(1,0),
					 Vector2i(-1,1), Vector2i(0,1), Vector2i(1,1)]

var childrenToRemove: Dictionary

func _ready() -> void:
	for x in range(0, hSectors):
		for y in range(0, vSectors):
			sectorBank[Vector2i(x,y)] = []
			childrenToRemove[Vector2i(x,y)] = []
	
	$Sprite2D2.apply_central_force(Vector2(5000,0))

#func _physics_process(_delta: float) -> void:

func _process(_delta: float) -> void:
	CalculateShipGlobalSector()
	ReleaseNodes()
	
	for sectorToBankInto in childrenToRemove.keys():
		var nodes: Array = childrenToRemove[sectorToBankInto]
		while nodes.size() > 0:
			var node = nodes[0]
			remove_child(node)
			nodes.remove_at(0)
			sectorBank[sectorToBankInto].append(node)
			
	for node in get_tree().get_nodes_in_group("test"):
		if IsNodeOutsideRange(node):
			ScheduleForBanking(node)
	
	#print(GetWrappedSector(globalSector))
	
func CalculateShipGlobalSector() -> void:
	var shipPosition: Vector2 = $Player.position + Vector2.ONE * sectorSize/2
	
	var modXPos = shipPosition.x - fposmod(shipPosition.x, sectorSize)
	var modYPos = shipPosition.y - fposmod(shipPosition.y, sectorSize)
	
	globalSector.x = int(modXPos / sectorSize)
	globalSector.y = int(modYPos / sectorSize)

func IsNodeOutsideRange(node: Node2D) -> bool:
	if abs(globalSector.x * sectorSize - node.position.x) > sectorSize * 1.5:
		return true
	
	if abs(globalSector.y * sectorSize - node.position.y) > sectorSize * 1.5:
		return true
	
	return false
	
func ScheduleForBanking(node) -> void:
	var skrtPosition: Vector2 = node.position + Vector2.ONE * sectorSize / 2
	var modXPos = skrtPosition.x - fposmod(skrtPosition.x, sectorSize)
	var modYPos = skrtPosition.y - fposmod(skrtPosition.y, sectorSize)
	var skrtSector = Vector2i(int(modXPos / sectorSize), int(modYPos / sectorSize))
	
	var sectorToBankInto = GetWrappedSector(skrtSector)
	print("Will bank into: " + str(sectorToBankInto))
	var newPosition: Vector2
	newPosition.x = fposmod(node.position.x, sectorSize)
	newPosition.y = fposmod(node.position.y, sectorSize)
	
	if node is RigidBody2D:
		PhysicsServer2D.body_set_state(node.get_rid(),
		PhysicsServer2D.BODY_STATE_TRANSFORM,
		Transform2D.IDENTITY.translated(newPosition))
	else:
		node.position = newPosition
	
	childrenToRemove[sectorToBankInto].append(node)

func GetWrappedSector(sector: Vector2i) -> Vector2i:
	var wrappedX = int(fposmod(sector.x, hSectors))
	var wrappedY = int(fposmod(sector.y, vSectors))
	
	return Vector2i(wrappedX, wrappedY)
	
func ReleaseNodes() -> void:
	for sectorDelta in sectorDeltas:
		
		var sectorToRelease = GetWrappedSector(sectorDelta + globalSector)
		
		while sectorBank[sectorToRelease].size() > 0:
			var nodes = sectorBank[sectorToRelease]
			var node = nodes[0]
			
			var newPosition = sectorDelta * sectorSize
			sectorBank[sectorToRelease].remove_at(0)
			add_child(node)
			
			if node is RigidBody2D:
				PhysicsServer2D.body_set_state(node.get_rid(),
				PhysicsServer2D.BODY_STATE_TRANSFORM,
				Transform2D.IDENTITY.translated(Vector2(-500,0)))
			else:
				node.position += newPosition
