extends Light2D

export var battery = 300
onready var player = get_tree().get_nodes_in_group("player")[0]

func _ready():
	player.connect("recharged", self, "_recharge_battery")
	$Timer.connect("timeout", self, "_depleate_battery")

func _process(delta):
	_change_direction()

func _input(event):
	if event.is_action_pressed("light"):
		if !visible and battery > 0:
			visible = true
			$Timer.start()
		else:
			visible = false
			$Timer.stop()

func _change_direction():
	look_at(get_global_mouse_position())
	rotate(deg2rad(90.0))

func _depleate_battery():
	battery -= 1
	if battery <= 0:
		visible = false
		$Timer.stop()
	
func _recharge_battery():
	battery = 10