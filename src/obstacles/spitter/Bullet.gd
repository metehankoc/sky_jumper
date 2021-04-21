extends Area2D

export(int, 0, 500, 50) var speed = 200
export(Vector2) var direction = Vector2(1,0)

onready var hitSound = $Hit

func _physics_process(delta):
	position += direction * speed * delta

func _on_Bullet_body_entered(body):
	if body.get_name() == "Char":
		Events.emit_signal("player_stopped")
		hitSound.play()
		direction = Vector2(0,0)


func _on_Hit_finished():
	Events.emit_signal("player_killed")
	queue_free()
