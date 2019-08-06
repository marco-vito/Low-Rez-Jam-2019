extends Node2D

signal interact(trigger)

func _ready():
	$Prompt.visible = false
	add_to_group("interactable")
	connect("interact", self, "_on_interact")
	$PromptArea.connect("body_entered", self, "_on_body_entered")
	$PromptArea.connect("body_exited", self, "_on_body_exited")

func interact(trigger):
	emit_signal("interact", trigger)

func _on_interact(trigger):
	print("Interacted with " + str(self) + " by " + str(trigger))

func _on_body_entered(body):
	if body is preload("res://Entities/Player/Player.gd"):
		$Prompt.visible = true

func _on_body_exited(body):
	if body is preload("res://Entities/Player/Player.gd"):
		$Prompt.visible = false