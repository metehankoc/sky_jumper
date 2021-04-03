extends Control

export(String, FILE, "*.tscn") var play_scene
export(String, FILE, "*.tscn") var about_scene

func _on_PlayButton_pressed():
	$Button.play()
	get_tree().change_scene(play_scene)

func _on_AboutButton_pressed():
	$Button.play()
	OS.shell_open("https://carpetgames.itch.io/")
	#get_tree().change_scene(about_scene)


