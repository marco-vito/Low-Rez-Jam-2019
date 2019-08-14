extends "res://Entities/Entity.gd"

signal recharged
signal update_map
signal mined(position)

enum States {IDLE, MOVING}
var state = States.IDLE
enum animations {IDLE, WALK}

func _init():
	add_to_group("player")

func _ready():
	$Sprites/Body.modulate = Global.bodyColor
	$Sprites/FootBack.modulate = Global.shoesColor
	$Sprites/FootFront.modulate = Global.shoesColor

func _physics_process(delta):
	check_input()
	check_movement()
	check_interaction()
	match state:
		States.IDLE:
			$Sprites/AnimationPlayer.play("idle")
		States.MOVING:
			move()
			$Sprites/AnimationPlayer.play("walk")
			_new_step_sound()

func _input(event):
	if event.is_action_pressed("pickaxe"):
		_mine()
	if event.is_action_pressed("debug"):
		_mine_all()

func check_interaction():
	if Input.is_action_just_pressed("interact"):
		for area in $InteractionArea.get_overlapping_areas():
			if area.get_owner().is_in_group("interactable") :
				area.get_owner().interact(self)

func check_input():
	direction.x = -int(Input.is_action_pressed("ui_left")) + int(Input.is_action_pressed("ui_right"))
	direction.y = -int(Input.is_action_pressed("ui_up")) + int(Input.is_action_pressed("ui_down"))
	if direction.x != 0:
		$Sprites.scale.x = -direction.x
	
func check_movement():
	if direction != Vector2(0,0):
		state = States.MOVING
	else:
		state = States.IDLE

func recharge_battery():
	emit_signal("recharged")

func _mine():
	var stream = load("res://Entities/Player/SoundEffects/PickaxeSwing"+str(randi()%2+1)+".wav")
	Global.audioController.play_sfx(stream)
	if is_on_wall():
		var tilemap = get_tree().get_nodes_in_group("map")[0]
		_mine_at(tilemap, (global_position + direction.normalized() * 16) / 16)

func _mine_at(map, pos):
	 var cell = map.get_cellv(pos)
		if cell == 0:
			map.set_cellv(pos, 1)
			map.update_bitmask_region()
			var stream = load("res://Entities/Player/SoundEffects/WallBreak"+str(randi()%2+1)+".wav")
			Global.audioController.play_sfx(stream, -10)
			emit_signal("update_map")
			emit_signal("mined", pos * 16)

func _mine_all():
	var tilemap = get_tree().get_nodes_in_group("map")[0]
	for i in 25:
		for j in 25:
			_mine_at(tilemap, Vector2(i,j))
	
func _new_step_sound():
	if !$StepSound.playing:
		var stream = load("res://Entities/Player/SoundEffects/PlayerStep"+str(randi()%3+1)+".wav")
		$StepSound.stream = stream
		$StepSound.play()
