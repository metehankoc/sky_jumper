extends Control

export(String, FILE, "*.tscn") var level_1
export(String, FILE, "*.tscn") var level_2
export(String, FILE, "*.tscn") var level_3
export(String, FILE, "*.tscn") var level_4
export(String, FILE, "*.tscn") var level_5
export(String, FILE, "*.tscn") var level_6
export(String, FILE, "*.tscn") var level_7
export(String, FILE, "*.tscn") var level_8
export(String, FILE, "*.tscn") var home


func _on_Level1_pressed():
	$Button.play()
	get_tree().change_scene(level_1)


func _on_Level2_pressed():
	$Button.play()
	get_tree().change_scene(level_2)


func _on_Level3_pressed():
	$Button.play()
	get_tree().change_scene(level_3)


func _on_Level4_pressed():
	$Button.play()
	get_tree().change_scene(level_4)


func _on_Level5_pressed():
	$Button.play()
	get_tree().change_scene(level_5)


func _on_Level6_pressed():
	$Button.play()
	get_tree().change_scene(level_6)


func _on_Level7_pressed():
	$Button.play()
	get_tree().change_scene(level_7)


func _on_Level8_pressed():
	$Button.play()
	get_tree().change_scene(level_8)


func _on_BackButton_pressed():
	$Button.play()
	get_tree().change_scene(home)
