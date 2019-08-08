extends Light2D

export var battery = 12
onready var player = get_tree().get_nodes_in_group("player")[0]

func _ready():
	player.connect("recharged", self, "_recharge_battery")
	$Timer.connect("timeout", self, "_deplete_battery")
	$Timer.start()

func _process(delta):
	_change_direction()
	$CanvasLayer/BatteryDisplay.value = battery

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

func _deplete_battery():
	battery -= 1
	var c = $CanvasLayer/BatteryDisplay.get("custom_styles/fg").get_bg_color()
	c.r = 1 - $CanvasLayer/BatteryDisplay.value / $CanvasLayer/BatteryDisplay.max_value
	c.g = $CanvasLayer/BatteryDisplay.value / $CanvasLayer/BatteryDisplay.max_value
	$CanvasLayer/BatteryDisplay.get("custom_styles/fg").set_bg_color(c)
	if battery <= 0:
		visible = false
		$Timer.stop()
	
func _recharge_battery():
	battery = 12