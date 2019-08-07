extends "res://Entities/Entity.gd"

enum states {HIDDEN, MOVING}
var state = states.MOVING

var spawnPosition

func _physics_process(delta):
	match state:
		states.MOVING:
			_moving()
		states.HIDDEN:
			_hidden()

func _moving():
	#move towards the player, play following sound, increase volume of following sound inversely to the distance from player
	pass

func _hidden():
	spawnPosition = global_position
	#play animation of disapearing once, stop following sound, emit shriek
	pass