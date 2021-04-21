extends KinematicBody2D

signal first_jump_location_added()

const CLOSENESS_DISTANCE = 0.5
const MAX_SPEED = 360
const MIN_SPEED = 180
const DECELERATION = -20

var locations = []
var loc_index = -1
var is_jumping = false
var landed = true

onready var current_state
onready var states = {
	"idle": $States/Idle,
	"jump": $States/Jump,
	"land": $States/Land,
	"stop": $States/Stop,
	"dead": $States/Dead
}

onready var speed = MAX_SPEED
onready var move_direction = Vector2()

onready var animated_sprite = $AnimatedSprite

func _ready():
# warning-ignore:return_value_discarded
	Events.connect("player_stopped", self, "_on_player_stopped")
# warning-ignore:return_value_discarded
	Events.connect("player_killed", self, "_on_player_killed")
	
	for state in $States.get_children():
		state.connect("state_changed", self, "_change_state")
	
	_init_char()

func _physics_process(delta):
	current_state._update(delta)
	
	if Input.is_action_just_pressed("ui_restart"):
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()


func _init_char():
	current_state = states["idle"]
	current_state._turn()
	current_state._enter()

func _change_state(state_name):
	if states[state_name] != null:
		current_state._exit()
	
		current_state = states[state_name]
		current_state._enter()


func _get_trajectory_positions():
	var res = []
	if loc_index < locations.size()-1:
		if loc_index < 0:
			res.append( self.position)
		else:
			res.append( locations[loc_index])
		res.append( locations[loc_index+1])
	return res


func play_sound_jump():
	$Jump.play()

func play_die_sound():
	$Die.play()


func add_new_location(new_pos):
	locations.append(new_pos)
	if locations.size() == 1:
		emit_signal("first_jump_location_added")


func _calculate_next_direction():
	var next_location = _get_next_location()
	if next_location != null:
		move_direction = next_location - position
		move_direction = move_direction.normalized()
	else:
		move_direction = Vector2(0,-1)
	return move_direction.angle()


func _get_next_location():
	if _has_locations():
		return locations[0]
	else:
		return null


func _has_locations():
	return locations.size() > 0


func _pop_location():
	if _has_locations():
		locations.pop_front()


func _on_first_jump_location_added():
	_change_state("idle")


func _on_player_stopped():
	_change_state("stop")
	pass


func _on_player_killed():
	play_die_sound()	
	_change_state("dead")


func _on_Die_sound_finished():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
