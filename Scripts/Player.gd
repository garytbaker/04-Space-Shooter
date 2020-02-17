extends KinematicBody2D

export var margin = 5
export var y_range = 300
export var acceleration = 3
export var health = 100
export var points = 0

onready var VP = get_viewport_rect().size

onready var Bullet_R = load("res://Scenes/Bullet_R.tscn")
var velocity = Vector2(0,0)

signal health_changed
signal score_changed

func _ready():
	emit_signal("health_changed")
	emit_signal("score_changed")

func change_health(h):
	health+=h
	emit_signal("health_changed")
	if health <=0:
		queue_free()
		get_tree().change_scene("res://Scenes/GameOver.tscn")
		
func change_score(s):
	points+=s
	emit_signal("score_changed")

func _physics_process(delta):
	velocity.x = 3*velocity.x/4
	velocity.y=3*velocity.y/4
	if Input.is_action_pressed("Fire"):
		var b = Bullet_R.instance()
		b.position = position
		b.position.y -= 25
		get_node("/root/Game/Bullets").shoot(b)
	if Input.is_action_pressed("Left"):
		velocity.x-= acceleration	
	if Input.is_action_pressed("Right"):
		velocity.x+= acceleration
	if Input.is_action_pressed("Up"):
		velocity.y-= acceleration
	if Input.is_action_pressed("Down"):
		velocity.y+= acceleration
		
	if position.x < margin:
		velocity.x =0
		position.x = margin
	if position.x > VP.x - margin:
		velocity.x =0
		position.x = VP.x-margin
	if position.y > VP.y-margin:
		velocity.y =0
		position.y = VP.y-margin
	if position.y < VP.y-y_range:
		velocity.y =0
		position.y = VP.y-y_range
	var collision=move_and_collide(velocity)
