extends Node2D

func _input(event):
	if event.is_action_pressed("pickaxe"):
		Global.totalLevels = 0
		get_tree().change_scene("res://Levels/Levels.tscn")
	elif event.is_action_pressed("ui_cancel"):
		get_tree().quit()