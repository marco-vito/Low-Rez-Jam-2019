extends Node2D

var height = 8
var width = 8
var tilesArray = []

func _ready():
	randomize()
	print(tilesArray)
	_set_array(tilesArray)
	print(tilesArray)
	_draw_tiles(tilesArray)

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
