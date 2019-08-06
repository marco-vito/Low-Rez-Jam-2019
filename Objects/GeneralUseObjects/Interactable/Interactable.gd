extends Node2D

signal interact(trigger)

func _ready():
	add_to_group("interactable")
	connect("interact", self, "_on_interact")

func interact(trigger):
	emit_signal("interact", trigger)

func _on_interact(trigger):
	pass