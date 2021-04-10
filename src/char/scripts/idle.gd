extends "State.gd"

func _enter():
	owner.get_node("AnimatedSprite").play("idle")
	
	_calculate_next_direction()
	_turn()


func _exit():
	pass


func _update(delta):
	if Input.is_action_just_pressed("ui_accept"):
		_jump()


func _jump():
	emit_signal("state_changed", "jump")


func _calculate_next_direction():
	var next_location = owner._get_next_location()
	if next_location != null:
		owner.move_vector.x = next_location.x - owner.position.x
		owner.move_vector.y = next_location.y - owner.position.y
		owner.move_direction = owner.move_vector.normalized()
	else:
		owner.move_direction = Vector2(0,-1)


func _turn():
	owner.rotation = owner.move_direction.angle()
