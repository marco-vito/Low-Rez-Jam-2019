extends KinematicBody2D

const SPEED = 20

#Arrays, enum and var to control the direction of movement and raycasts. [North, South, East, West].
var dirX = [0, 0, 16, -16]
var dirY = [-16, 16, 0, 0]

var directions = {"up": Vector2(0,-1),
				"down": Vector2(0,1),
				"left": Vector2(1,0),
				"right": Vector2(-1,0)}

var direction = Vector2(0,0)

#Function to add four raycasts, which will check for collisions with walls before each grid-based movement
func set_raycasts():
	for i in range(dirX.size()-1):
		var NewRaycast = RayCast2D.new()
		add_child(NewRaycast)
		NewRaycast.cast_to = Vector2(dirX[i],dirY[i])
		NewRaycast.collide_with_areas = true
		NewRaycast.collision_mask = 2
		NewRaycast.add_to_group("raycasts")

func move():
	var velocity = direction.normalized() * SPEED
	move_and_slide(velocity, Vector2(0,0))