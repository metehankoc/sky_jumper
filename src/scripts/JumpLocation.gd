extends Node2D

func _ready():	
	var character = get_tree().get_root().get_child(1).get_node("Char")
	if character != null:
		character.add_new_location( self.position)

func _physics_process(delta):
	"""
	var position = get_tree().get_root().get_child(1).get_node("Char")._get_next_position()
	if position == self.position:
		$AnimatedSprite.modulate = Color(255,0,0)
		$AnimatedSprite.play("next")
	else:
		$AnimatedSprite.modulate = Color(255,255,255)
		$AnimatedSprite.play("idle")
	"""	
	pass

