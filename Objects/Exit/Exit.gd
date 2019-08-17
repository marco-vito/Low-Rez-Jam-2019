extends "res://Objects/GeneralUseObjects/Interactable/Interactable.gd"

func _init():
	add_to_group("exit")

func _ready():
	var sfx = preload("res://Objects/Exit/ExitEmerge.wav")
	Global.audioController.play_sfx(sfx, -10)

func _on_interact(trigger):
	Global.totalLevels += 1
	var stream = preload("res://Levels/StairsTransition.wav")
	var transition = get_tree().get_nodes_in_group("transition")[0]
	if Global.totalLevels >= 3:
		transition.transition(stream, "res://Levels/FinalRoom.tscn")
	else:
		transition.transition(stream, "res://Levels/Levels.tscn")