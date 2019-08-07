extends Node2D

func _on_interact(trigger):
	trigger.recharge_battery()