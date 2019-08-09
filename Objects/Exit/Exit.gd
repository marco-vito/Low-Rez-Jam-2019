extends "res://Objects/GeneralUseObjects/Interactable/Interactable.gd"

signal nextLevel

func _ready():
	add_to_group("exit")

func _on_interact(trigger):
	emit_signal("nextLevel")