extends "res://Entities/Entity.gd"

var moving = false

func _ready():
	set_raycasts()
	
func _input(event):
	if event:
		if event.is_action_pressed("ui_left"):
			direction = Vector2(dirX[Directions.LEFT], dirY[Directions.LEFT])
		elif event.is_action_pressed("ui_right"):
			direction = Vector2(dirX[Directions.RIGHT], dirY[Directions.RIGHT])
		elif event.is_action_pressed("ui_up"):
			direction = Vector2(dirX[Directions.UP], dirY[Directions.UP])
		elif event.is_action_pressed("ui_down"):
			direction = Vector2(dirX[Directions.DOWN], dirY[Directions.DOWN])
		moving = true
		_check_movement()
		
func _check_movement():
	if moving:
		move()
		moving = false
