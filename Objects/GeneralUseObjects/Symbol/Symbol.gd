extends "res://Objects/GeneralUseObjects/Interactable/Interactable.gd"

export (PackedScene) var toInstanciated

onready var flashlight = get_tree().get_nodes_in_group("flashlight")[0]
var player

func _ready():
	_set_visibility(true)
	player = get_tree().get_nodes_in_group("player")[0]
	player.connect("mined", self, "_make_visible")
	call_deferred("_assign_exit")

func _input(event):
	if event.is_action_pressed("print"):
		print(get_name()+" position x: "+str(global_position.x)+" position y: "+str(global_position.y))
	
#Function to assign the "exit" group value that'll be found by the Pointer
func _assign_exit():
	if toInstanciated == preload("res://Objects/Exit/Exit.tscn"):
		add_to_group("exit")

#Function to control if the sign is visible or not. It should only be visible in the dark.
func _set_visibility(flashlight : bool):
	visible = not flashlight

#Makes symbol disappear and the object it carries be instanciated:
func _on_interact(trigger):
	if visible:
		var object = toInstanciated.instance()
		object.global_position = self.global_position
		get_tree().get_nodes_in_group("ysort")[0].add_child(object)
		queue_free()
	
#Makes the symbol invisible while the wall wasn't mined:
func _make_visible(pos):
	pos.x = round(pos.x)*16
	pos.y = round(pos.y)*16
	if (global_position.x >= pos.x and global_position.y >= pos.y) and (global_position.x <= pos.x+24 and global_position.y <= pos.y+24):
		flashlight.connect("on", self, "_set_visibility", [true])
		flashlight.connect("off", self, "_set_visibility", [false])
		_set_visibility(flashlight.visible)
		print(get_name()+" is visible")