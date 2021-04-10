extends Area2D

export(int, 0 , 500, 50) var speed = 200
export(String, "Right", "Left") var direction

onready var hitSound = $Hit
onready var dieSound = $Die 

func _physics_process(delta):
	if direction == "Right":
		position += transform.x * speed * delta * -1
	else:
		position += transform.x * speed * delta

func _on_Bullet_body_entered(body):
	Events.emit_signal("player_stopped")
	hitSound.play()
	queue_free()


func _on_Hit_finished():
	dieSound.play()


func _on_Die_finished():
	Events.emit_signal("player_killed")
