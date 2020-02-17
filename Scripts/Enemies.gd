extends Node2D


export var max_enemies = 10
export var probability = .2
onready var Enemy = load("res://Scenes/Enemy.tscn")
func _ready():
	randomize()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	if get_child_count()<max_enemies+1:
		if randf()<probability:
			var e = Enemy.instance()
			add_child(e)
