extends Line2D

onready var character = get_tree().get_root().get_child(0).get_node("Char")

func _process(_delta):
	if character != null:
		if character._is_landed():
			var points = character._get_trajectory_positions()
			
			if points.size() >= 2:
				show()
				clear_points()
				add_point( points[0])
				add_point( points[1])
		else:
			hide()
