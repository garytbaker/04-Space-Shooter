extends Camera2D


export var shakeVal = 20
var base = 0
func _ready():
	pass
func _physics_process(delta):
	offset=Vector2(rand_range(-base,base),rand_range(-base,base))
	base*=.9
	if base<.01:
		base=0
	print(base)



func _on_Player_health_changed():
	base=shakeVal



