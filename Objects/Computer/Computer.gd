extends "res://Objects/GeneralUseObjects/Interactable/Interactable.gd"

func _on_interact(trigger):
	get_tree().get_nodes_in_group("gateway")[0].queue_free()
	yield(get_tree().create_timer(1.0), "timeout")
	get_tree().change_scene("res://MainScenes/Credits.tscn")