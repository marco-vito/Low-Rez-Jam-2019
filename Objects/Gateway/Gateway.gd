extends "res://Objects/GeneralUseObjects/Interactable/Interactable.gd"

func _on_interact(trigger):
	Global.credit = "gateway"
	get_tree().change_scene("res://MainScenes/Credits.tscn")