extends KinematicBody2D

signal jump_location_added()

const CLOSENESS_DISTANCE = 2
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
	"stop": $States/Stop
}

onready var speed = MAX_SPEED
onready var move_vector = Vector2()
onready var move_direction = Vector2()

onready var animated_sprite = $AnimatedSprite

func _ready():
	Events.connect("player_stopped", self, "_on_player_stopped")
	Events.connect("player_killed", self, "_on_player_killed")
	
	self.connect("jump_location_added", self, "_on_jump_location_added")
	
	for state in $States.get_children():
		state.connect("state_changed", self, "_change_state")
	
	current_state = states["idle"]
	current_state._enter()

func _physics_process(delta):
	current_state._update(delta)
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().reload_current_scene()
		#get_tree().change_scene("res://src/LevelSelect.tscn")


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

func play_sound_die():
	$Die.play()


func add_new_location(new_pos):
	locations.append(new_pos)
	if locations.size() == 1:
		emit_signal("jump_location_added")


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


func _on_jump_location_added():
	_change_state("idle")


func _on_player_stopped():
	_change_state("stop")
	pass


func _on_player_killed():
	if current_state != states["stop"]:
		play_sound_die()


func _on_Die_sound_finished():
	get_tree().reload_current_scene()
