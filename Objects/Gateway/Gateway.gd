extends "res://Objects/GeneralUseObjects/Interactable/Interactable.gd"

func _ready():
	add_to_group("gateway")

func _on_interact(trigger):
	var sfx = preload("res://Objects/Gateway/StargateInteract.wav")
	Global.audioController.play_sfx(sfx, -10)
	get_tree().get_nodes_in_group("player")[0].visible = false
	yield(get_tree().create_timer(2.0), "timeout")
	get_tree().change_scene("res://MainScenes/Credits.tscn")