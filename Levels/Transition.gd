extends CanvasLayer

var stream

func level_transition():
	$ColorRect.visible = true
	$AudioStreamPlayer.stream = stream
	$AudioStreamPlayer.connect("finished", $ColorRect, "hide")
	