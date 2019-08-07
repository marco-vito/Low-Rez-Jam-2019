extends "res://Objects/GeneralUseObjects/Interactable/Interactable.gd"

func _on_interact(trigger):
	if $Particles2D.emitting:
		trigger.recharge_battery()
		$Particles2D.emitting = false