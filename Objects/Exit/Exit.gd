extends "res://Objects/GeneralUseObjects/Interactable/Interactable.gd"

export (PackedScene) var nextLevel

func _on_interact(trigger):
	get_tree().change_scene(nextLevel)