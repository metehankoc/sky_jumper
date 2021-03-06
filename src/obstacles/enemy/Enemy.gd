extends KinematicBody2D

export(int) var height = 128
export var moving_left = false
export(int, "Left", "Middle", "Right") var start_point


onready var collision_shape = $CollisionShape2D
onready var animated_sprite = $AnimatedSprite

const MAX_SPEED = 80
const ACCELERATION = 10

var min_h
var max_h

var motion = Vector2.ZERO

func _ready():
	collision_shape.disabled = true
	match start_point:
		0:
			min_h = self.position.x
			max_h = min_h + height
		1:
			min_h = self.position.x - height / 2
			max_h = min_h + height
		2:
			max_h = self.position.x
			min_h = max_h - height


func _physics_process(delta):
	if moving_left:
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
	else:
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
	
	if _is_on_edge():
		# maybe add turn animation
		moving_left = !moving_left
		animated_sprite.flip_v = moving_left
	
	move_and_slide(motion)


func _is_on_edge():
	if position.x < min_h || position.x > max_h:
		motion.x = 0
		if position.x < min_h:
			position.x = min_h
		else:
			position.x = max_h
		return true
	return false


func _on_PlayerDetector_body_entered(body):
	Events.emit_signal("player_killed")
