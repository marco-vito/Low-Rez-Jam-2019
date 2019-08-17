extends "res://Entities/Entity.gd"

enum States {HIDDEN, MOVING}
var state = States.MOVING

var flashlight
var player
var nav

var path = PoolVector2Array() setget set_path
var speed = 5

func _ready():
	add_to_group("enemy")
	nav = get_tree().get_root().get_node("Level").get_node("Navigation2D")
	player = get_tree().get_nodes_in_group("player")[0]
	player.connect("update_map", self, "_update_path")	
	flashlight = get_tree().get_nodes_in_group("flashlight")[0]
	flashlight.connect("on", self, "_hidden_state")
	flashlight.connect("off", self, "_moving_state")
	$Area2D.connect("area_entered", self, "_check_defeat")
	call_deferred("_update_path")

func _physics_process(delta):
	match state:
		States.MOVING:
			_moving()
		States.HIDDEN:
			_hidden()

func _moving():
	visible = true
	if path.size() > 1:
		var d = global_position.distance_to(path[0])
		if d > 2:
			direction = global_position.direction_to(path[0])
			move()
		else:
			path.remove(0)
	else:
		_update_path()
		
func _hidden():
	visible = false

func _hidden_state():
	state = States.HIDDEN
	Global.audioController.play_sfx(preload("res://Entities/Enemy/SpiderVanish.wav"), -10)
	_burrow()
	$AudioStreamPlayer2D.stop()

func _moving_state():
	state = States.MOVING
	Global.audioController.play_sfx(preload("res://Entities/Enemy/SpiderEmerge.wav"), -10)
	$AudioStreamPlayer2D.play()

func set_path(value : PoolVector2Array):
    path = value

func _update_path():
	set_path(nav.get_simple_path(global_position, player.global_position, false))

func _check_defeat(area):
	if state == States.MOVING:
		for area in $Area2D.get_overlapping_areas():
			if area.get_owner().is_in_group("player"):
				Global.bodyColor = Color(randf(), randf(), randf())
				Global.shoesColor = Color(randf(), randf(), randf())
				get_tree().get_nodes_in_group("transition")[0].transition(preload("res://Levels/DeathTransition.wav"), "res://Levels/Levels.tscn")


func _burrow():
	var particle = preload("res://Objects/Particles/Burrowing.tscn").instance()
	particle.global_position = global_position
	get_tree().get_root().add_child(particle)
	particle.emitting = true