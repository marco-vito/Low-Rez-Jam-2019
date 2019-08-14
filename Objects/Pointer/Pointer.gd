extends Node2D

var exit

func _ready():
	var sfx = preload("res://Objects/Pointer/PointerEmerge.wav")
	Global.audioController.play_sfx(sfx, -10)
	exit = get_tree().get_nodes_in_group("exit")[0]
	look_at(exit.global_position)