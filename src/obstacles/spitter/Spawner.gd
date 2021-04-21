extends Area2D

export (PackedScene) var Bullet

export(float, 0, 5, 0.5) var activation_time = 1.0
export(String, "Right", "Left") var direction

onready var timer = $Timer
onready var animated_sprite = $AnimatedSprite

func _ready():
	timer.set_wait_time( activation_time)
	timer.start()
	if direction == "Right":
		animated_sprite.play("default")
	else:
		animated_sprite.flip_h = true
		animated_sprite.play("default")


func _on_Timer_timeout():
	var bullet =  Bullet.instance()
	if direction == "Right":
		bullet.direction = "Right"
	add_child( bullet )


func _on_MiniTimer_timeout():
	pass

