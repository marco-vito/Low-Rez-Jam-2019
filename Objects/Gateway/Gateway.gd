extends "res://Objects/GeneralUseObjects/Interactable/Interactable.gd"

func _ready():
	add_to_group("gateway")

func _on_interact(trigger):
	get_tree().get_nodes_in_group("player")[0].visible = false
	yield(get_tree().create_timer(2.0), "timeout")
	get_tree().change_scene("res://MainScenes/Credits.tscn")