extends "res://Objects/GeneralUseObjects/Interactable/Interactable.gd"

func _on_interact(trigger):
	get_tree().change_scene("res://Levels/FinalRoom.tscn")