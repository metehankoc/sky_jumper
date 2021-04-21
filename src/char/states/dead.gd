extends "../State.gd"

onready var animatedSprite = owner.get_node("AnimatedSprite")

func _enter():
	owner.move_and_slide(Vector2(0,0))
	animatedSprite.stop()
	


func _exit():
	pass


func _update(_delta):
	pass
