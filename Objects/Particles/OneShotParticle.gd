extends Particles2D
func _ready():
	var t = Timer.new()
	t.start(lifetime*2)
	t.connect("timeout", self, "queue_free")
	add_child(t)