extends "res://Objects/GeneralUseObjects/Interactable/Interactable.gd"

export var random : bool = true
export var message : String

var sfx = preload("res://Objects/Slate/SlateInteract.wav")

#Variable to control if the interaction should show the text or hide it
var interactable = true

func _ready():
	var sound = preload("res://Objects/Slate/SlateEmerge.wav")
#	Global.audioController.play_sfx(sound, -10)
	$Sprite.texture.region.size.y = 0
	if random:
		var key = randi()%Global.messages.size()
		message = Global.messages[key]
		Global.messages.erase(key)
	$CanvasLayer/ColorRect/RichTextLabel.text = message
	
func _process(delta):
	if $Sprite.texture.region.size.y < 32:
		$Sprite.texture.region.size.y += 1
	else:
		$LightOccluder2D.visible = true

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