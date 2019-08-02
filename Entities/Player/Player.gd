extends "res://Entity.gd"

const SPEED = 200

func _input(event):
	if event.is_action_pressed("ui_left"):
		direction = LEFT
	elif event.is_action_pressed("ui_right"):
		direction = RIGHT
	elif event.is_action_pressed("ui_up"):
		direction = UP
	elif event.is_action_pressed("ui_down"):
		direction = DOWN