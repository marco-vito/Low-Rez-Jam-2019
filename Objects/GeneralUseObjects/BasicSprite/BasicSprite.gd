extends Sprite

export var vfr = 1
export var hfr = 1
export var frctn = 0
export var speed = 0.05
export var loop = true

func _ready():
    vframes = vfr
    hframes = hfr
    var animation = Animation.new()
    animation.set_length(speed * (frctn)) # -1
    animation.add_track(0)
    animation.track_set_path(0, str(get_path(),":frame"))
    animation.step = speed
    for i in frctn:
        animation.track_insert_key(0, i * speed, i + 1)
    animation.loop = loop
    $AnimationPlayer.add_animation("default", animation)
    $AnimationPlayer.play("default")