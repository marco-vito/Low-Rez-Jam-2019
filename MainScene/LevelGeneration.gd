extends Node2D

#Varibales to control the size of the level beign generated
export var width = 0
export var height = 0

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
	var map : Array = _inicialize_2D_array(width, height, Tiles.WALLS)
	map = _set_random_paths(map, randi()%width, randi()%height, 4, 3)
	return map 

func _inicialize_2D_array(sizeX, sizeY, defaultValue):
	var array = []
	for x in range(sizeX):
		array.append([])
		for y in range(sizeY):
			array[x].append(defaultValue)
	return array
	
func _set_random_paths(array, startX, startY, steps, paths):
	var x = startX
	var y = startY
	while steps > 0:
		if array[x][y] != Tiles.FLOOR:
			array[x][y] = Tiles.FLOOR
			steps -= 1
		var r = randi()%dirX.size()
		x = clamp(x+dirX[r], 0, array.size())
		y = clamp(x+dirY[r], 0, array[x].size())
	paths -= 1
	if paths <= 0:
		return
	_set_random_paths(array, randi()%x, randi()%y, steps, paths)