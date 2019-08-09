extends "res://Entities/Entity.gd"

signal reached

enum States {HIDDEN, MOVING}
var state = States.HIDDEN

onready var flashlight = get_tree().get_nodes_in_group("flashlight")[0]
onready var player = get_tree().get_nodes_in_group("player")[0]
onready var nav = get_tree().get_root().get_node("Level").get_node("Navigation2D")

var path = PoolVector2Array() setget set_path
var speed = 20

func _ready():
	flashlight.connect("on", self, "_hidden_state")
	flashlight.connect("off", self, "_moving_state")
	player.connect("update_map", self, "_update_path")
	call_deferred("_update_path")

func _physics_process(delta):
	match state:
		States.MOVING:
			_moving()
		States.HIDDEN:
			_hidden()

func _moving():
	if path.size() > 1:
		var d = global_position.distance_to(path[0])
		if d > 5:
			global_position.linear_interpolate(path[0], speed/d)
		else:
			path.remove(0)
	else:
		emit_signal("reached")
		
func _hidden():
	#play animation of disappearing once, stop following sound, emit shriek
	pass

func _hidden_state():
	state = States.HIDDEN

func _moving_state():
	state = States.MOVING

func set_path(value : PoolVector2Array):
    path = value

func _update_path():
	set_path(nav.get_simple_path(global_position, player.global_position, false))