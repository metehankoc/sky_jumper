extends "../State.gd"

export(int) var TURN_SPEED = 10

onready var ANGLE_CLOSENESS = owner.CLOSENESS_DISTANCE * PI / 180
onready var original_rotation = 0
onready var angle = 0

func _enter():
	owner.get_node("AnimatedSprite").play("idle")
	
	original_rotation = owner.rotation
	angle = owner._calculate_next_direction()
	#_turn()

func _exit():
	pass


func _update(delta):
	if Input.is_action_just_pressed("ui_accept"):
		_jump()
		
	if !_angle_close_to(angle):
		owner.rotation += (angle - original_rotation) * delta * TURN_SPEED


func _jump():
	_turn()
	emit_signal("state_changed", "jump")


func _angle_close_to(next_angle):
	if abs(next_angle - owner.rotation) <= ANGLE_CLOSENESS:
		return true
	return false

func _turn():
	if angle == null:
		angle = owner._calculate_next_direction()
	owner.rotation = owner.move_direction.angle()
