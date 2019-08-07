extends "res://Objects/GeneralUseObjects/Interactable/Interactable.gd"

export (PackedScene) var toInstanciated

#Variable to control if the object is on the light or not
var illuminated : bool = false setget _SetIlluminated

#Function to control if the sign is visible or not. It should only be visible in the dark.
func _SetIlluminated(parameter : bool):
	illuminated = parameter
	if parameter:
		$Sign.visible = false
	else:
		$Sign.visible = true

func _on_interact(trigger):
	var object = toInstanciated.instance()
	object.global_position = self.global_position
	get_parent().add_child(object)
	queue_free()