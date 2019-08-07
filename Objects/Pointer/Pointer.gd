extends Node2D

var exit

func _ready():
	exit = get_tree().get_nodes_in_group("exit")[0]
	look_at(exit.global_position)