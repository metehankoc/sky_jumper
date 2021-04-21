extends "../State.gd"

onready var animatedSprite = owner.get_node("AnimatedSprite")

func _enter():
	animatedSprite.play("land")


func _exit():
	owner.position = owner._get_next_location()
	owner._pop_location()


func _handle_input(event):
	pass


func _update(delta):
	pass


func _on_animation_finished(anim_name):
	pass


func _on_AnimatedSprite_animation_finished():
	if animatedSprite.get_animation() == "land":
		emit_signal("state_changed", "idle")
