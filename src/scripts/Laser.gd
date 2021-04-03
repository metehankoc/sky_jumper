extends Area2D

export(float) var activation_time

onready var character = get_tree().get_root().get_child(0).get_node("Char")

var active = true

func _ready():
	$Timer.set_wait_time( activation_time)
	$Timer.start()

func _on_Timer_timeout():
	var time = 0.2
	if active:
		$AnimatedSprite.play("turnoff")
		$L1.set_disabled( true)
		$L5.set_disabled( true)
		yield(get_tree().create_timer(time), "timeout")
		#_wait(time)
		$L2.set_disabled( true)
		$L6.set_disabled( true)
		yield(get_tree().create_timer(time), "timeout")
		$L3.set_disabled( true)
		$L7.set_disabled( true)
		yield(get_tree().create_timer(time), "timeout")
		$L4.set_disabled( true)
		$L8.set_disabled( true)
		#$CollisionShape2D.set_disabled( true)
		active = false
	else:
		$AnimatedSprite.play("turnon")
		$L4.set_disabled( false)
		$L8.set_disabled( false)
		yield(get_tree().create_timer(time), "timeout")
		$L3.set_disabled( false)
		$L7.set_disabled( false)
		yield(get_tree().create_timer(time), "timeout")
		$L2.set_disabled( false)
		$L6.set_disabled( false)
		yield(get_tree().create_timer(time), "timeout")
		$L1.set_disabled( false)
		$L5.set_disabled( false)
		#$CollisionShape2D.set_disabled( false)
		active = true


func _on_Laser_body_entered(body):
	if body.get_name() == "Char":
		if character != null:
			character._die()
		$Laser.play()


func _on_AnimatedSprite_animation_finished():
	if( $AnimatedSprite.get_animation() == "turnon"):
		$AnimatedSprite.play("default")


func _on_Die_finished():
	get_tree().reload_current_scene()


func _on_Laser_finished():
	$Die.play()

func _wait(sec):
	var t = Timer.new()
	t.set_wait_time(sec)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()

