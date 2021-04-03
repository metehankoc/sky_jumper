extends Area2D

export(int) var speed

onready var character = get_tree().get_root().get_child(0).get_node("Char")

var direction = -1

"""
Direction
-1 for down
1 for up
"""

func _physics_process(delta):
	position += transform.x * speed * delta * direction


func _on_Bullet_body_entered(body):
	if body.name == "Char":
		if character != null:
			character._die()
		$Hit.play()
	else:
		queue_free()



func _on_Hit_finished():
	$Die.play()


func _on_Die_finished():
	get_tree().reload_current_scene()
