extends "res://Objects/GeneralUseObjects/Interactable/Interactable.gd"

export var random : bool = true
export var message : String

#Variable to control if the interaction should show the text or hide it
var interactable = true

func _ready():
	$CanvasLayer/ColorRect.visible = false
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
	else:
		$CanvasLayer/ColorRect.visible = false
		interactable = true
