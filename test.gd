extends Node2D

var sectorSize = 100 # The min/max coordinates that a sector spans
var activeSector = Vector2i(0,0) # The sector the player is in
var sectorBank: Dictionary # Maps nodes to a sector

const vSectors: int = 10
const hSectors: int = 10

func _ready() -> void:
	for x in range(0, hSectors - 1):
		for y in range(0, vSectors - 1):
			sectorBank[Vector2i(x,y)] = []

func _process(_delta: float) -> void:
	var xMove = Input.get_axis("0_move_left", "0_move_right")
	var yMove = Input.get_axis("0_move_up", "0_move_down")
	
	$Player.velocity = Vector2(xMove, yMove) * 200
	$Player.move_and_slide()
	
	HandleSectorWrapping()

func HandleSectorWrapping() -> void:
	if $Player.position.x > sectorSize:
		$Player.position.x = 0
		ShiftSector(Vector2i(1,0))
		for node in get_tree().get_nodes_in_group("test"):
			node.position.x -= sectorSize
			BankNode(node)
		
	if $Player.position.x < 0:
		$Player.position.x = sectorSize
		ShiftSector(Vector2i(-1,0))
		for node in get_tree().get_nodes_in_group("test"):
			node.position.x += sectorSize
			BankNode(node)
		
	if $Player.position.y < 0:
		$Player.position.y = sectorSize
		ShiftSector(Vector2i(0,-1))
		for node in get_tree().get_nodes_in_group("test"):
			node.position.y += sectorSize
			BankNode(node)
	
	if $Player.position.y > sectorSize:
		$Player.position.y = 0
		ShiftSector(Vector2i(0,1))
		for node in get_tree().get_nodes_in_group("test"):
			node.position.y -= sectorSize
			BankNode(node)

	print(activeSector)
	return

func ShiftSector(shift: Vector2i) -> void:
	activeSector = activeSector + shift
	
	#BankSectors()
	ReleaseSectors()

func BankNode(node) -> void:
	if node.position.x < (activeSector.x - 2) * sectorSize:
		#node.position.x += sectorSize
		sectorBank[activeSector + Vector2i(-2,0)].append(node)
		remove_child(node)
		return
			
	if node.position.x > (activeSector.x + 2) * sectorSize:
		#node.position.x -= sectorSize
		sectorBank[activeSector + Vector2i(2,0)].append(node)
		remove_child(node)
		return
			
	if node.position.y < (activeSector.y - 2) * sectorSize:
		#node.position.y += sectorSize
		sectorBank[activeSector + Vector2i(0,-2)].append(node)
		remove_child(node)
		return
			
	if node.position.y > (activeSector.y + 2) * sectorSize:
		#node.position.y -= sectorSize
		sectorBank[activeSector + Vector2i(0,2)].append(node)
		remove_child(node)
		return
			
func BankSectors() -> void:
	for node in get_tree().get_nodes_in_group("test"):
		if node.position.x < (activeSector.x - 2) * sectorSize:
			node.position.x += sectorSize
			sectorBank[activeSector + Vector2i(-2,0)].append(node)
			remove_child(node)
			continue
			
		if node.position.x > (activeSector.x + 2) * sectorSize:
			node.position.x -= sectorSize
			sectorBank[activeSector + Vector2i(2,0)].append(node)
			remove_child(node)
			continue
			
		if node.position.y < (activeSector.y - 2) * sectorSize:
			node.position.y += sectorSize
			sectorBank[activeSector + Vector2i(0,-2)].append(node)
			remove_child(node)
			continue
			
		if node.position.y > (activeSector.y + 2) * sectorSize:
			node.position.y -= sectorSize
			sectorBank[activeSector + Vector2i(0,2)].append(node)
			remove_child(node)
			continue

func ReleaseSectors() -> void:
	var skrt = [Vector2i(-1,-1), Vector2i(-1, 0), Vector2i(-1,1), Vector2i(0,-1), Vector2i(0,1), Vector2i(1,-1), Vector2i(1,0), Vector2i(1,1)]
	for i in range(0, skrt.size() - 1):
		skrt[i] += activeSector
		
	for index: Vector2i in sectorBank.keys():
		if not index in skrt:
			continue
		var sectorNodes: Array = sectorBank[index]
		
		while sectorNodes.size() > 0:
			var node = sectorNodes[0]
			add_child(node)
			sectorNodes.remove_at(0)
		
