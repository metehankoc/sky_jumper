extends "../State.gd"

var next_location

onready var speed = owner.MAX_SPEED
onready var motion = Vector2()

func _enter():
	speed = owner.MAX_SPEED
	next_location = owner._get_next_location()
	if next_location == null:
		next_location = owner.position
		emit_signal("state_changed", "idle")
	
	owner.play_sound_jump()
	owner.get_node("AnimatedSprite").play("jump")


func _exit():
	pass


func _update(delta):
	if _close_to(next_location):
		_land()
	else:
		_apply_movement()


func _land():
	motion = Vector2(0,0)
	owner.move_and_slide(motion)
	emit_signal("state_changed", "land")


func _apply_movement():
	speed = max(speed + owner.DECELERATION, owner.MIN_SPEED)
	motion = speed * owner.move_direction
	owner.move_and_slide(motion)


func _close_to(next_pos):
	if abs(next_pos.x - owner.position.x) <= owner.CLOSENESS_DISTANCE || abs(next_pos.y - owner.position.y) <= owner.CLOSENESS_DISTANCE:
		return true
	return false
