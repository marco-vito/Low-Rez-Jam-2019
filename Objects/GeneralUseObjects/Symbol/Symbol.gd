extends "res://Objects/GeneralUseObjects/Interactable/Interactable.gd"

export (PackedScene) var toInstanciated

onready var flashlight = get_tree().get_nodes_in_group("flashlight")[0]

#Variable to control if the object is on the light or not
var illuminated : bool = true setget _SetIlluminated

func _ready():
	_SetIlluminated(true)
	flashlight.connect("on", self, "_SetIlluminated", [true])
	flashlight.connect("off", self, "_SetIlluminated", [false])
	if toInstanciated == preload("res://Objects/Exit/Exit.tscn"):
		add_to_group("exit")

#Function to control if the sign is visible or not. It should only be visible in the dark.
func _SetIlluminated(parameter : bool):
	illuminated = parameter
	if parameter:
		visible = false
	else:
		visible = true

func _on_interact(trigger):
	var object = toInstanciated.instance()
	object.global_position = self.global_position
	get_parent().add_child(object)
	queue_free()