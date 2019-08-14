extends Node2D

#Varibales to control the size of the level beign generated
export var width = 16
export var height = 16

#Arrays to control the direction of the steps for the random generation of tile. [North, South, East, West].
var dirX = [-1, 1, 0, 0]
var dirY = [0, 0, 1, -1]

var spawnratesSymbol = { # Avg amount spawned
	"res://Objects/Slate/Slate.tscn" : 2,
	"res://Objects/Pointer/Pointer.tscn" : 2,
}

var spawnratesDirect = {
	"res://Objects/Crystal/Crystal.tscn" : 2
}

const TILESIZE = 16
enum Tiles {FLOOR = 1, WALLS = 0, BORDERS = 2}

func _ready():
	$YSort.add_to_group("ysort")
	$Symbols.add_to_group("symbol")
	var mapArray = _generate_floor_map()
	_spawn_at_random_pos(mapArray, "res://Entities/Player/Player.tscn", Tiles.FLOOR)
	_spawn_at_random_pos(mapArray, "res://Objects/RechargeStation/RechargeStation.tscn", Tiles.FLOOR)
	_spawn_at_random_pos(mapArray, "res://Objects/GeneralUseObjects/Symbol/Symbol.tscn", Tiles.WALLS, false)
	for i in Global.totalLevels:
		_spawn_at_random_pos(mapArray, "res://Entities/Enemy/Enemy.tscn", Tiles.FLOOR)
	_position_objects(mapArray)
	_2D_array_to_tilemap(mapArray, $Navigation2D/TileMapWalls)

func _position_objects(map):
	for toSpawn in spawnratesSymbol.keys():
		var amount = randi()%int(spawnratesSymbol[toSpawn] * 1.5)
		for i in amount:
			var symbol = _spawn_at_random_pos(map, "res://Objects/GeneralUseObjects/Symbol/Symbol.tscn", Tiles.WALLS, false)
			symbol.toInstanciated = load(toSpawn)
			
	for toSpawn in spawnratesDirect.keys():
		var amount = randi()%int(spawnratesDirect[toSpawn] * 1.5)
		for i in amount:
			_spawn_at_random_pos(map, toSpawn, Tiles.FLOOR)

func _spawn_at_random_pos(map, path_to_node, tile, ysort : bool = true):
	var pos = _get_random_space(map, tile) * TILESIZE
	var object = load(path_to_node).instance()
	if ysort:
		get_tree().get_nodes_in_group("ysort")[0].add_child(object)
	else:
		get_tree().get_nodes_in_group("symbol")[0].add_child(object)
	object.global_position = pos + Vector2(TILESIZE/2, TILESIZE/2)
	return object

func _get_random_space(array, tile):
	# @TODO check for instance at position
	var x = randi()%width
	var y = randi()%height
	while (array[x][y] != tile):
		x = randi()%width
		y = randi()%height
	return Vector2(x,y)

func _generate_floor_map():
	var map : Array = _initialize_2D_array(width, height, Tiles.WALLS)
	_set_random_paths(map, 3, 7, 4)
	_set_random_rooms(map, 4, 8, 5)
	_outline_with_walls(map)
	return map 

func _outline_with_walls(map):
	for h in range(height):
		for w in range(width):
			if h == 0 or h == height - 1:
				map[w][h] = Tiles.BORDERS
			if w == 0 or w == width - 1:
				map[w][h] = Tiles.BORDERS

func _initialize_2D_array(sizeX, sizeY, defaultValue):
	var array = []
	for x in range(sizeX):
		array.append([])
		for y in range(sizeY):
			array[x].append(defaultValue)
	return array
	
func _set_random_paths(array, minSize, maxSize, count):
	for c in count:
		var x = randi()%(array.size()-1)
		var y = randi()%(array[x].size()-1)
		var steps = randi()%(maxSize-minSize)+minSize
		_create_random_path(array, x, y, steps)

func _create_random_path (array, startX, startY, steps):
	var x = startX
	var y = startY
	while steps > 0:
		if array[x][y] != Tiles.FLOOR:
			array[x][y] = Tiles.FLOOR
			steps -= 1
		var r = randi()%dirX.size()
		x = clamp(x+dirX[r], 0, array.size()-1)
		y = clamp(y+dirY[r], 0, array[x].size()-1)
	
func _set_random_rooms(array, minSize, maxSize, count):
	for c in count:
		var x = randi()%(array.size()-1)
		var y = randi()%(array[x].size()-1)
		var width = randi()%(maxSize-minSize)+minSize
		var height = randi()%(maxSize-minSize)+minSize
		_create_room(array, x, y, width, height)

func _create_room(array, startX, startY, width, height):
	var x = startX
	var y = startY
	for w in range(width):
		x = clamp(x+1, 0, array.size()-1)
		y = startY
		for h in range(height):
			if array[x][y] != Tiles.FLOOR:
				array[x][y] = Tiles.FLOOR
				y = clamp(y+1, 0, array[x].size()-1)

func _2D_array_to_tilemap(array, tileMap):
	for x in range(array.size()):
		for y in range(array[x].size()):
			tileMap.set_cell(x,y, array[x][y])
	tileMap.update_bitmask_region()
