extends "res://Objects/GeneralUseObjects/Interactable/Interactable.gd"

export var random : bool = true
export var message : String

var sfx = preload("res://Objects/Slate/SlateInteract.wav")

#Variable to control if the interaction should show the text or hide it
var interactable = true

func _ready():
	var sound = preload("res://Objects/Slate/SlateEmerge.wav")
	Global.audioController.play_sfx(sound, -10)
	_set_message()

func _on_interact(trigger):
	if interactable:
		interactable = false
		$CanvasLayer/ColorRect.visible = true
		$Timer.start()
		Global.audioController.play_sfx(sfx, -10)
	else:
		$CanvasLayer/ColorRect.visible = false
		interactable = true
		Global.audioController.play_sfx(sfx, -10)

func _on_Timer_timeout():
	$CanvasLayer/ColorRect.visible = false
	interactable = true
	Global.audioController.play_sfx(sfx, -10)

func _set_message():
	if random:
		Global.messageArray.shuffle()
		var key = Global.messageArray[0]
		message = Global.messages[key]
		Global.messageArray.remove(0)
	$CanvasLayer/ColorRect/RichTextLabel.text = message