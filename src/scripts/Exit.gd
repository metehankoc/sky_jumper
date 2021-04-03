extends Area2D

export(String, FILE, "*.tscn") var next_scene

func _process(_delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.get_name() == "Char":
			get_tree().change_scene( next_scene)
