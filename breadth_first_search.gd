class_name BreadthFirstSearcher
extends Node

var queue : Array[Node]
var unallocatedSections
var unvisitedSections: Array[Node]
var unvisitedPositions: Array[Vector2]
const sectorWidth: float = 64

func GetNumberOfRegions(sections: Array[Node]) -> int:
	var regions: Array[Array] = ExtractAllRegions(sections)

	return regions.size()

func ExtractAllRegions(sections: Array[Node]) -> Array[Array]:
	unvisitedSections = sections
	
	for section in unvisitedSections:
		unvisitedPositions.append(section.position)
		
	var regions: Array[Array]
	
	while unvisitedSections.size() > 0:
		var region = ExtractRegion()
		regions.append(region)
	
	return regions
	
func ExtractRegion() -> Array[Node]:
	var region: Array[Node]
	
	queue.append(unvisitedSections.pop_front())
	unvisitedPositions.remove_at(0)

	while queue.size() > 0:
		var checkedSection: Node2D = queue.pop_front()
		region.append(checkedSection)
		# Get neighbours
		var neighbours: Array[Node] = GetNeighbours(checkedSection)
		
		for neighbour in neighbours:
			queue.append(neighbour)
	
	return region
	
func GetNeighbours(section: Node) -> Array[Node]:
	var neighbours: Array[Node]
	const offsets = [Vector2.UP, Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT]
	
	for i in range(0,4):
		var neighbourIndex = unvisitedPositions.find(section.position + offsets[i] * sectorWidth)
		
		if neighbourIndex == -1:
			continue
		
		neighbours.append(unvisitedSections.pop_at(neighbourIndex))
		unvisitedPositions.remove_at(neighbourIndex)
		
	return neighbours
	
