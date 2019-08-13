extends "res://Objects/GeneralUseObjects/Interactable/Interactable.gd"

func _init():
	add_to_group("exit")

func _on_interact(trigger):
	Global.totalLevels += 1
	if Global.totalLevels >= 3:
		get_tree().change_scene("res://Levels/FinalRoom.tscn")
	else:
		get_tree().reload_current_scene()