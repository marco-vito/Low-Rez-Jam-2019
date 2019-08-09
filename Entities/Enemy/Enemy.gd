extends "res://Entities/Entity.gd"

enum States {HIDDEN, MOVING}
var state = States.HIDDEN

onready var flashlight = get_tree().get_nodes_in_group("flashlight")[0]

var spawnPosition

func _ready():
	flashlight.connect("On", self, "_hidden_state")
	flashlight.connect("Off", self, "_moving_state")

func _physics_process(delta):
	match state:
		States.MOVING:
			_moving()
		States.HIDDEN:
			_hidden()

func _moving():
	#move towards the player, play unburrow sound, play following sound, increase volume of following sound inversely to the distance from player
	pass

func _hidden():
	spawnPosition = global_position
	#play animation of disappearing once, stop following sound, emit shriek
	pass

func _hidden_state():
	state = States.HIDDEN

func _moving_state():
	state = States.MOVING