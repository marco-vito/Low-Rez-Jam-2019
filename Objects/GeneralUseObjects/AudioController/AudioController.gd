extends Node

var bgm_volume = -10
var sfx_volume = -5
var sfx_stream = null
var bgm_stream = null
var next_bgm = null
var fading = false

var bgm_volume_setting = 0
var sfx_volume_setting = 0

signal settings_changed

func _ready():
	connect("settings_changed", self, "_on_settings_changed")

func _on_settings_changed():
	if bgm_stream != null:
		bgm_stream.volume_db = (bgm_volume) + (10 * bgm_volume_setting)
	if sfx_stream != null:
		sfx_stream.volume_db = (sfx_volume) + (10 * sfx_volume_setting)

func _process(delta):
	if fading:
		if bgm_stream.volume_db > bgm_volume * 2:
			bgm_stream.volume_db -= 0.1
		elif(next_bgm != null):
			bgm_stream = next_bgm
			bgm_stream.play()
			bgm_stream.volume_db = bgm_volume + (10 * bgm_volume_setting)
			next_bgm = null

func play_sfx(sfx, volume = 0):
	if sfx_stream != null:
		sfx_stream.stream = sfx
		sfx_stream.volume_db = (sfx_volume + volume) + (10 * sfx_volume_setting)
		sfx_stream.play()

func play_bgm(bgm, fade = true, volume = 0):
	if bgm_stream != null:
		if fade:
			fading = true
			next_bgm = bgm
		else:
			bgm_stream.stream = bgm
			bgm_stream.volume_db = (bgm_volume + volume) + (10 * bgm_volume_setting)
			bgm_stream.play()