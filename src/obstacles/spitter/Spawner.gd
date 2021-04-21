extends Area2D

export (PackedScene) var Bullet

export(float, 0,5, 0.5) var activation_time = 1.0

onready var timer = $Timer
onready var animated_sprite = $AnimatedSprite

func _ready():
	timer.set_wait_time( activation_time)
	timer.start()
	animated_sprite.play("default")


func _on_Timer_timeout():
	var bullet =  Bullet.instance()
	bullet.direction = Vector2(cos(deg2rad(rotation)), sin(deg2rad(rotation)))
	add_child( bullet)
