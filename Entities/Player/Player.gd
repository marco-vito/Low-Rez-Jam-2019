extends "res://Entities/Entity.gd"

signal recharged
signal update_map

enum States {IDLE, MOVING}
var state = States.IDLE
enum animations {IDLE, WALK}

func _init():
	add_to_group("player")

func _physics_process(delta):
	check_input()
	check_movement()
	match state:
		States.IDLE:
			$Sprites/AnimationPlayer.play("idle")
			check_interaction()
		States.MOVING:
			move()
			$Sprites/AnimationPlayer.play("walk")

func _input(event):
	if event.is_action_pressed("pickaxe"):
		_mining()

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

func _mining():
	#Add sound effect and animation
	if is_on_wall():
		var tilemap = get_tree().get_root().get_node("Level").get_node("Navigation2D").get_node("TileMapWalls")
		var cell = tilemap.get_cellv((global_position + direction.normalized() * 16) / 16)
		if cell == 5:
			tilemap.set_cellv((global_position + direction.normalized() * 16) / 16, 6)
			tilemap.update_bitmask_region()
			emit_signal("update_map")