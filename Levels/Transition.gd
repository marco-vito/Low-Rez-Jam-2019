extends CanvasLayer

func _ready():
	add_to_group("transition")

func transition(stream, path):
	$ColorRect.visible = true
	get_tree().get_nodes_in_group("level")[0].queue_free()
	$AudioStreamPlayer.stream = stream
	$AudioStreamPlayer.connect("finished", $ColorRect, "hide")
	$AudioStreamPlayer.play()
	get_tree().change_scene(path)
