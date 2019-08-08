extends "res://Objects/GeneralUseObjects/Interactable/Interactable.gd"

func _on_interact(trigger):
	if $Light2D.enabled:
		trigger.recharge_battery()
		$Light2D.enabled = false