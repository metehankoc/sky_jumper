extends Area2D

export(float) var activation_time = 2

var turn_on_frame_time
var turn_off_frame_time
var turn_on_left_trajectory = [PoolVector2Array(),PoolVector2Array(),PoolVector2Array(),PoolVector2Array()]
var turn_on_right_trajectory = [PoolVector2Array(),PoolVector2Array(),PoolVector2Array(),PoolVector2Array()]
var turn_off_left_trajectory = [PoolVector2Array(),PoolVector2Array(),PoolVector2Array(),PoolVector2Array()]
var turn_off_right_trajectory = [PoolVector2Array(),PoolVector2Array(),PoolVector2Array(),PoolVector2Array()]

onready var active = true
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
	#print( colLeft.polygon[0])
	#print( colLeft.polygon[1])
	#print( colLeft.polygon[2])
	#print( colLeft.polygon[3])
	#print(animatedSprite.get_sprite_frames().get_frame_count("turnoff"))
	#print(animatedSprite.get_sprite_frames().get_frame_count("turnon"))
	#print(animatedSprite.get_sprite_frames().get_frame_count("off"))
	#print(animatedSprite.get_sprite_frames().get_frame_count("on"))
	print(animatedSprite.get_sprite_frames().get_animation_speed("turnon"))
	print(animatedSprite.get_sprite_frames().get_frame_count("turnon"))
	
	if active:
		turn_off()
		#colRight.polygon[2] = colRight.polygon[1]
		#colRight.polygon[3] = colRight.polygon[0]
	else:
		turn_on()
	

func turn_off():
	animatedSprite.play("turnoff")
	
	active = false


func turn_on():
	animatedSprite.play("turnon")
	active = true


func _on_Laser_body_entered(body):
	if body.get_name() == "Char":
		Events.emit_signal("player_stopped")
		laserSound.play()


func _on_AnimatedSprite_animation_finished():
	if( animatedSprite.get_animation() == "turnon"):
		animatedSprite.play("on")
		timer.start()
	if( animatedSprite.get_animation() == "turnoff"):
		animatedSprite.play("off")
		timer.start()


func _on_Laser_finished():
	Events.emit_signal("player_killed")


func calculate_turn_on_procedure():
	var speed = animatedSprite.get_sprite_frames().get_animation_speed("turnon")
	var frame_count = animatedSprite.get_sprite_frames().get_frame_count("turnon")
	 
	turn_on_frame_time = 1 / speed
	
	for i in range(frame_count):
		var 
		
		pass
	
	pass


func calculate_turn_off_procedure():
	pass
