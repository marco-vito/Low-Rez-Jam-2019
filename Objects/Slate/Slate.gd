extends "res://Objects/GeneralUseObjects/Interactable/Interactable.gd"

#variable to control if the interaction should show the text or hide it
var interactable = true

func _ready():
	set_process(false)
	$PromptArea/CollisionShape2D.disabled = true
	$Sprite/StaticBody2D/CollisionShape2D.disabled = true
	$CanvasLayer/RichTextLabel.visible = false
	$Sprite.texture.region.size.y = 0
	$Signal.connect("used", self, "_setSlate")
	
func _process(delta):
	if $Sprite.texture.region.size.y < 32:
		$Sprite.texture.region.size.y += 1

#Function to unborrow the Slate
func _setSlate():
	set_process(true)
	$Sprite/StaticBody2D/CollisionShape2D.disabled = false
	$PromptArea/CollisionShape2D.disabled = false

func _on_interact(trigger):
	if interactable:
		interactable = false
		$CanvasLayer/RichTextLabel.visible = true
	else:
		$CanvasLayer/RichTextLabel.visible = false
		interactable = true
