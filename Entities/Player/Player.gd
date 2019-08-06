extends "res://Entities/Entity.gd"

var animDirection = "right"

enum States {IDLE, MOVING}
var state = States.IDLE

func _ready():
	add_to_group("player")

func _physics_process(delta):
	check_movement()
	check_interaction()
	match state:
		States.IDLE:
			_set_anim("idle")
		States.MOVING:
			move()
			_set_anim("walk")

func check_interaction():
	if Input.is_action_just_pressed("interact"):
		for area in $InteractionArea.get_overlapping_areas():
			if area.get_owner().is_in_group("interactable") :
				area.get_owner().interact(self)

func check_movement():
	if Input.is_action_pressed("ui_left"):
		direction = Vector2(dirX[Directions.LEFT], dirY[Directions.LEFT])
		animDirection = "left"
	elif Input.is_action_pressed("ui_right"):
		direction = Vector2(dirX[Directions.RIGHT], dirY[Directions.RIGHT])
		animDirection = "right"
	elif Input.is_action_pressed("ui_up"):
		direction = Vector2(dirX[Directions.UP], dirY[Directions.UP])
		animDirection = "right"
	elif Input.is_action_pressed("ui_down"):
		direction = Vector2(dirX[Directions.DOWN], dirY[Directions.DOWN])
		animDirection = "right"
	else:
		direction = Vector2(0,0)
	if direction != Vector2(0,0):
		state = States.MOVING
	else:
		state = States.IDLE

func _set_anim(animation):
	var newAnim = str(animation, animDirection)
	if $Sprites/AnimationPlayer.current_animation != newAnim:
		$Sprites/AnimationPlayer.play(newAnim)
