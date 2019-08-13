extends "res://Objects/GeneralUseObjects/Interactable/Interactable.gd"

func _on_interact(trigger):
	Global.credit = "computer"
	get_tree().change_scene("res://MainScenes/Credits.tscn")