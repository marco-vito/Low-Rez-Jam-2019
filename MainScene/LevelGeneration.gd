extends Node2D

#Varibales to control the size of the level beign generated
export var width = 24
export var height = 24

#Arrays to control the direction of the steps for the random generation of tile. [North, South, East, West].
var dirX = [-1, 1, 0, 0]
var dirY = [0, 0, 1, -1]

#Enum to control layers of tilesets
enum Tiles {FLOOR, WALLS}

func _ready():
	randomize()
	var mapArray = _generate_floor_map()
	for row in mapArray:
		print(row)

func _generate_floor_map():
	var map : Array = _initialize_2D_array(width, height, Tiles.WALLS)
	_set_random_paths(map, randi()%(width-1), randi()%(height-1), 7, 5)
	_set_random_rooms(map, randi()%(width-1), randi()%(height-1), 5, 6)
	return map 

func _initialize_2D_array(sizeX, sizeY, defaultValue):
	var array = []
	for x in range(sizeX):
		array.append([])
		for y in range(sizeY):
			array[x].append(defaultValue)
	return array
	
func _set_random_paths(array, startX, startY, steps, paths):
	var x = startX
	var y = startY
	var initialSteps = steps
	while steps > 0:
		if array[x][y] != Tiles.FLOOR:
			array[x][y] = Tiles.FLOOR
			steps -= 1
		var r = randi()%dirX.size()
		x = clamp(x+dirX[r], 0, array.size()-1)
		y = clamp(y+dirY[r], 0, array[x].size()-1)
	paths -= 1
	if paths <= 0:
		return
	_set_random_paths(array, randi()%(array.size()-1), randi()%(array[x].size()-1), initialSteps, paths)
	
func _set_random_rooms(array, startX, startY, maxSize, rooms):
	var x = startX
	var y = startY
	var sizeX = randi()%(maxSize-1)+1
	var sizeY = randi()%(maxSize-1)+1
	for w in range(sizeX):
		x = clamp(x+1, 0, array.size()-1)
		y = startY
		for h in range(sizeY):
			if array[x][y] != Tiles.FLOOR:
				array[x][y] = Tiles.FLOOR
				y = clamp(y+1, 0, array[x].size()-1)
	rooms -= 1
	if rooms <= 0:
		return
	_set_random_rooms(array, randi()%(array.size()-1), randi()%(array[x].size()-1), maxSize, rooms)
