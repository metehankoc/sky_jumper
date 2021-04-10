extends KinematicBody2D

const CLOSENESS_DISTANCE = 5
const MAX_SPEED = 360
const MIN_SPEED = 180
const DECELERATION = -20

onready var speed = MAX_SPEED
onready var motion = Vector2()
onready var move_direction = Vector2()

onready var animated_sprite = $AnimatedSprite

var locations = []
var loc_index = -1
var is_jumping = false
var landed = true

func _ready():
	Events.connect("player_stopped", self, "_on_player_stopped")
	Events.connect("player_killed", self, "_on_player_killed")

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept") && landed:
		if loc_index < locations.size()-1:
			loc_index += 1
		_jump()
	elif Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://src/LevelSelect.tscn")
		
	if !landed && _close_to(locations[loc_index]):
		_land()
	_apply_movement()

func _calculate_direction(index):
	if index < locations.size():
		move_direction.x = locations[index].x - self.position.x
		move_direction.y = locations[index].y - self.position.y
		move_direction = move_direction.normalized()
	else:
		move_direction.x = 1
		move_direction.y = 0

func _turn():
	self.rotation = move_direction.angle()

func _get_trajectory_positions():
	var res = []
	if loc_index < locations.size()-1:
		if loc_index < 0:
			res.append( self.position)
		else:
			res.append( locations[loc_index])
		res.append( locations[loc_index+1])
	return res
	
func _is_landed():
	return landed
	
func _close_to(next_pos):
	if abs(next_pos.x - self.position.x) <= CLOSENESS_DISTANCE && abs(next_pos.y - self.position.y) <= CLOSENESS_DISTANCE:
		return true
	return false

func _jump():
	$Jump.play()
	is_jumping = true
	landed = false
	animated_sprite.play("jump")

func _land():
	is_jumping = false
	self.position = locations[loc_index]
	animated_sprite.play("land")

func _apply_movement():
	if is_jumping:
		speed = max( speed + DECELERATION, MIN_SPEED)
		motion.x = speed * move_direction.x
		motion.y = speed * move_direction.y
	else:
		speed = MAX_SPEED
		motion.x = 0
		motion.y = 0
	move_and_slide(motion)
	
func _die():
	landed = false
	is_jumping = false
	motion = Vector2()

func add_new_location(new_pos):
	locations.append(new_pos)
	print("New pos added")
	if locations.size() == 1:
		_calculate_direction(0)
		_turn()

func _on_AnimatedSprite_animation_finished():
	if animated_sprite.get_animation() == "land":
		animated_sprite.play("idle")
		_calculate_direction(loc_index+1)
		_turn()
		landed = true

func _get_next_position():
	if loc_index < locations.size() -2:
		return locations[loc_index+1]


func _on_player_stopped():
	#change state to stopped or somthing
	_die()


func _on_player_killed():
	print("Player killed")
	get_tree().reload_current_scene()
	pass
