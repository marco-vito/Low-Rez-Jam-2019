extends StaticBody2D

#Variable to control if the object is on the light or not
var illuminated : bool = false setget _SetIlluminated

#Variable to control if the object is still a sign or if the Slate was already unborrowed
var isSign = true

#Variable to stop the player from interacting with the same object more than once
var interacting = true

func _ready():
	$CanvasLayer.visible = false
	$Slate.texture.region.size.y = 0

#Function to control if the sign is visible or not. It should only be visible in the dark.
func _SetIlluminated(parameter : bool):
	if isSign:
		illuminated = parameter
		if parameter:
			$Sign.visible = false
		else:
			$Sign.visible = true

#Function to unborrow the Slate and make the sign disappear
func _setSlate():
	while $Slate.texture.region.size.y < 32:
		$Slate.texture.region.size.y += 1
	isSign = false
	$CollisionShape2D.disabled = false
	interacting = true

#Function to show text:
func _read():
	$CanvasLayer.visible = true
	if Input.is_action_pressed("interact"):
		$CanvasLayer.visible = false
		interacting = true
		
#Function to interact:
func _interact():
	if interacting:
		interacting = false
		if isSign:
			_setSlate()
		else:
			_read()

func _on_InteractableArea_body_entered(body):
	if body.get_name() == "Player":
		if Input.is_action_pressed("interact"):
			_interact()
