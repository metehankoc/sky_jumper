extends Area2D

export(float) var activation_time = 2

var stop = false

var turn_on_frame_time
var turn_on_left_trajectory = []
var turn_on_right_trajectory = []

var turn_off_frame_time
var turn_off_left_trajectory = []
var turn_off_right_trajectory = []

var active = true

onready var animatedSprite = $AnimatedSprite
onready var laserSound = $Laser
onready var timer = $Timer
onready var colLeft = $CollisionLeft
onready var colRight = $CollisionRight

func _ready():
	calculate_turn_off_procedure()
	calculate_turn_on_procedure()
	timer.set_wait_time( activation_time)
	timer.start()


func _on_Timer_timeout():	
	if active:
		turn_off()
	else:
		turn_on()
	

func turn_off():
	var frame_count = animatedSprite.get_sprite_frames().get_frame_count("turnoff")
	animatedSprite.play("turnoff")
	for i in range(0, frame_count):
		if stop:
			animatedSprite.stop()
			break
		colLeft.polygon = turn_off_left_trajectory[i]
		colRight.polygon = turn_off_right_trajectory[i]
		yield(get_tree().create_timer(turn_off_frame_time), "timeout")
	
	active = false


func turn_on():
	var frame_count = animatedSprite.get_sprite_frames().get_frame_count("turnon")
	animatedSprite.play("turnon")
	for i in range(0, frame_count):
		if stop:
			animatedSprite.stop()
			break
		colLeft.polygon = turn_on_left_trajectory[i]
		colRight.polygon = turn_on_right_trajectory[i]
		yield(get_tree().create_timer(turn_on_frame_time), "timeout")
	
	active = true


func _on_Laser_body_entered(body):
	if body.get_name() == "Char":
		_stop_laser()
		Events.emit_signal("player_stopped")
		laserSound.play()


func _on_AnimatedSprite_animation_finished():
	if( animatedSprite.get_animation() == "turnon"):
		animatedSprite.play("on")
		timer.start()
	if( animatedSprite.get_animation() == "turnoff"):
		animatedSprite.play("off")
		timer.start()


func _stop_laser():
	timer.stop()
	stop = true
	animatedSprite.stop()


func _restart_laser():
	stop = false
	timer.start()
	animatedSprite.play()

func _on_Laser_finished():
	Events.emit_signal("player_killed")


func calculate_turn_off_procedure():
	var speed = animatedSprite.get_sprite_frames().get_animation_speed("turnoff")
	var frame_count = animatedSprite.get_sprite_frames().get_frame_count("turnoff")
	 
	turn_off_frame_time = 1 / speed
	
	var leftDiff2 = colLeft.polygon[1] - colLeft.polygon[2]
	var leftDiff3 = colLeft.polygon[0] - colLeft.polygon[3]
	
	for i in range(1, frame_count+1):
		var current_polygon = PoolVector2Array()
		current_polygon.append(colLeft.polygon[0])
		current_polygon.append(colLeft.polygon[1])
		current_polygon.append(colLeft.polygon[2] + (leftDiff2*i/frame_count))
		current_polygon.append(colLeft.polygon[3] + (leftDiff3*i/frame_count))
		turn_off_left_trajectory.append(current_polygon)
	
	var rightDiff2 = colRight.polygon[1] - colRight.polygon[2]
	var rightDiff3 = colRight.polygon[0] - colRight.polygon[3]
	for i in range(1, frame_count+1):
		var current_polygon = PoolVector2Array()
		current_polygon.append(colRight.polygon[0])
		current_polygon.append(colRight.polygon[1])
		current_polygon.append(colRight.polygon[2] + (rightDiff2*i/frame_count))
		current_polygon.append(colRight.polygon[3] + (rightDiff3*i/frame_count))
		turn_off_right_trajectory.append(current_polygon)


func calculate_turn_on_procedure():
	var speed = animatedSprite.get_sprite_frames().get_animation_speed("turnon")
	var frame_count = animatedSprite.get_sprite_frames().get_frame_count("turnon")
	 
	turn_on_frame_time = 1 / speed
	
	var leftDiff2 = colLeft.polygon[2] - colLeft.polygon[1]
	var leftDiff3 = colLeft.polygon[3] - colLeft.polygon[0]
	
	for i in range(1, frame_count+1):
		var current_polygon = PoolVector2Array()
		current_polygon.append(colLeft.polygon[0])
		current_polygon.append(colLeft.polygon[1])
		current_polygon.append(colLeft.polygon[1] + (leftDiff2*i/frame_count))
		current_polygon.append(colLeft.polygon[0] + (leftDiff3*i/frame_count))
		turn_on_left_trajectory.append(current_polygon)
	
	var rightDiff2 = colRight.polygon[2] - colRight.polygon[1]
	var rightDiff3 = colRight.polygon[3] - colRight.polygon[0]
	for i in range(1, frame_count+1):
		var current_polygon = PoolVector2Array()
		current_polygon.append(colRight.polygon[0])
		current_polygon.append(colRight.polygon[1])
		current_polygon.append(colRight.polygon[1] + (rightDiff2*i/frame_count))
		current_polygon.append(colRight.polygon[0] + (rightDiff3*i/frame_count))
		turn_on_right_trajectory.append(current_polygon)
