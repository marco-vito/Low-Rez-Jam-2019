extends "res://Entities/Entity.gd"

var animDirection = "right"

enum States {IDLE, MOVING}
var state = States.IDLE

func _ready():
	add_to_group("player")

func _physics_process(delta):
	check_input()
	check_movement()
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

func check_input():
	if Input.is_action_pressed("ui_left"):
		direction = directions["left"]
		animDirection = "left"
	elif Input.is_action_pressed("ui_right"):
		direction = directions["right"]
		animDirection = "right"
	if Input.is_action_pressed("ui_up"):
		direction = directions["up"]
		animDirection = "right"
	elif Input.is_action_pressed("ui_down"):
		direction = directions["down"]
		animDirection = "right"
	else:
		direction = Vector2(0,0)
	if direction != Vector2(0,0):
		print(direction)
		
func check_movement():
	if direction != Vector2(0,0):
		state = States.MOVING
	else:
		state = States.IDLE

func _set_anim(animation):
	var newAnim = str(animation, animDirection)
	if $Sprites/AnimationPlayer.current_animation != newAnim:
		$Sprites/AnimationPlayer.play(newAnim)
