#extends Node2D
#
#var level = preload("res://Levels/Levels.tscn")
#var totalLevels = 3
#onready var exit = get_tree().get_nodes_in_group("exit")[0]
#
#func _ready():
#	_new_level()
#
#func _new_level():
#	var newLevel = level.instance()
#	add_child(newLevel)
#	exit.connect("nextLevel", self, "_update_game")
#
#func _update_game():
#	get_child(0).queue_free()
#	totalLevels -= 1
#	if totalLevels <= 0:
#		_new_level()