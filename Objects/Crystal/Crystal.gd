extends "res://Objects/GeneralUseObjects/Interactable/Interactable.gd"

signal broke

func _ready():
	self.connect("broke", $AudioStreamPlayer2D, "stop")

func _on_interact(trigger):
	if $Light2D.enabled:
		trigger.recharge_battery()
		$Light2D.enabled = false
		var sfx = preload("res://Objects/Crystal/CristalBreak.wav")
		Global.audioController.play_sfx(sfx, -10)
		emit_signal("broke")