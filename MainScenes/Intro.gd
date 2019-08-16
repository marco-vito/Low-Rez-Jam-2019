extends Sprite

func _input(event):
	if event.is_action_pressed("pickaxe") or event.is_action_pressed("light"):
		get_tree().change_scene("res://Levels/Levels.tscn")