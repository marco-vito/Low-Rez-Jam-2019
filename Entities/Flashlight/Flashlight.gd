extends Light2D

signal on
signal off

export var battery = 10
onready var player = get_tree().get_nodes_in_group("player")[0]
var streamOn = preload("res://Entities/Flashlight/FlashlightOn.wav")
var streamOff = preload("res://Entities/Flashlight/FlashlightOff.wav")

func _init():
	add_to_group("flashlight")

func _ready():
	visible = false
	player.connect("recharged", self, "_recharge_battery")
	$Timer.connect("timeout", self, "_deplete_battery")

func _process(delta):
	_change_direction()
	$CanvasLayer/BatteryDisplay.value = battery

func _input(event):
	if event.is_action_pressed("light"):
		if !visible and battery > 0:
			visible = true
			emit_signal("on")
			Global.audioController.play_sfx(streamOn)
			$Timer.start()
		else:
			visible = false
			emit_signal("off")
			Global.audioController.play_sfx(streamOff)
			$Timer.stop()

func _change_direction():
	look_at(get_global_mouse_position())
	rotate(deg2rad(90.0))

func _deplete_battery():
	battery -= 1
	_set_color()
	if battery <= 0:
		visible = false
		emit_signal("off")
		Global.audioController.play_sfx(streamOff)
		$Timer.stop()
	
func _recharge_battery():
	battery = $CanvasLayer/BatteryDisplay.max_value
	_set_color()

func _set_color():
	var c = $CanvasLayer/BatteryDisplay.get("custom_styles/fg").get_bg_color()
	c.r = 1 - $CanvasLayer/BatteryDisplay.value / $CanvasLayer/BatteryDisplay.max_value
	c.g = $CanvasLayer/BatteryDisplay.value / $CanvasLayer/BatteryDisplay.max_value
	$CanvasLayer/BatteryDisplay.get("custom_styles/fg").set_bg_color(c)