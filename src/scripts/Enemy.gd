extends KinematicBody2D

export(int) var height = 140
export(int, "Top", "Middle", "Bottom") var start_point
export var moving_down = false

onready var character = get_tree().get_root().get_child(0).get_node("Char")

const MAX_SPEED = 80
const ACCELERATION = 10

var min_h
var max_h

var motion = Vector2.ZERO

func _ready():
	$CollisionShape2D.disabled=true
	match start_point:
		0:
			min_h = self.position.y
			max_h = min_h + height
		1:
			min_h = self.position.y - height / 2
			max_h = min_h + height
		2:
			max_h = self.position.y
			min_h = max_h - height

func _physics_process(delta):
	if moving_down:
		motion.y = min(motion.y + ACCELERATION, MAX_SPEED)
	else:
		motion.y = max(motion.y - ACCELERATION, -MAX_SPEED)
	
	if position.y < min_h || position.y > max_h:
		motion.y = 0
		if position.y < min_h:
			position.y = min_h
		else:
			position.y = max_h
		moving_down = !moving_down
		$AnimatedSprite.flip_v = moving_down
		
	move_and_slide(motion)


func _on_PlayerDetector_body_entered(body):
	if body.name == "Char":
		if character != null:
			character._die()
		$Die.play()


func _on_Die_finished():
	get_tree().reload_current_scene()
