extends Node2D

func _input(event):
	if event.is_action_pressed("light"):
		Global.totalLevels = 3
		get_tree().change_scene("res://Levels/Levels.tscn")
	elif event.is_action_pressed("ui_cancel"):
		get_tree().quit()