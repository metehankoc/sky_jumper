extends Area2D

export (PackedScene) var Bullet

export(float) var activation_time
export(int, "down", "up")var direction
"""
up = 1
down = 0
"""


func _ready():
	$Timer.set_wait_time( activation_time)
	$Timer.start()
	if direction:
		$AnimatedSprite.play("default")
	else:
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("default")


func _on_Timer_timeout():
	var bullet =  Bullet.instance()
	if !direction:
		bullet.direction = 1
	add_child( bullet )


func _on_MiniTimer_timeout():
	pass

