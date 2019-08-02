extends Node2D

var height = 8
var width = 8
var tilesArray = []
var posX = 0
var posY = 0
var dirArray = ["North", "South", "East", "West"]

func _ready():
	randomize()
	_drunkard_walk()

func _set_array(array):
	for x in range(width):
		array.append([])
		for y in range(height):
			array[x].append(randi()%3)
	return array

func _draw_tiles(array):
	for x in range(width):
		for y in range(height):
			$TileMap.set_cell(x, y, array[x][y])

func _drunkard_walk():
	if posX > 8 or posY > 8:
		return
	if $TileMap.get_cell(posX, posY) != 2:
		$TileMap.set_cell(posX, posY, 2)	
	var direction = dirArray[randi()%dirArray.size()]
	if direction == "North":
		posY -= 1
		abs(posY)
	elif direction == "South":
		posY += 1
		abs(posY)
	elif direction == "East":
		posX += 1
		abs(posX)
	elif direction == "West":
		posX -= 1
		abs(posX)
	_drunkard_walk()
