extends Node2D

export(String, "Right", "Left") var direction
export(int) var height = 144
export(float, 0, 10, 0.5) var speed = 3.0
export(float, 0, 2, 0.1) var idleDuration = 0.5

onready var platform = $Platform
onready var tween = $Tween
onready var dieSound = $Die


var move_to

func _ready():
	$Platform/CollisionShape2D.disabled = true
	if direction == "Left":
		move_to = Vector2.LEFT * height
	else:
		move_to = Vector2.RIGHT * height
	_init_tween()

func _init_tween():
	var duration = move_to.length() / float(speed * 20)
	tween.interpolate_property(platform, "position", Vector2.ZERO, move_to, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, idleDuration)
	tween.interpolate_property(platform, "position", move_to, Vector2.ZERO, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, duration + idleDuration * 2)
	tween.start()


func _on_Area2D_body_entered(body):
	Events.emit_signal("player_stopped")
	dieSound.play()

func _on_Die_finished():
	Events.emit_signal("player_killed")
