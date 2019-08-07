extends "res://Objects/GeneralUseObjects/Interactable/Interactable.gd"

#variable to control if the interaction should show the text or hide it
var interactable = true

func _ready():
	$CanvasLayer/RichTextLabel.visible = false
	$Sprite.texture.region.size.y = 0
	
func _process(delta):
	if $Sprite.texture.region.size.y < 32:
		$Sprite.texture.region.size.y += 1

func _on_interact(trigger):
	if interactable:
		interactable = false
		$CanvasLayer/RichTextLabel.visible = true
	else:
		$CanvasLayer/RichTextLabel.visible = false
		interactable = true
