extends Control

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	pass

func _on_options_pressed():
	get_tree().change_scene_to_file("res://scenes/UI/OptionsMenu.tscn")
	pass # Replace with function body.

func _on_quit_pressed():
	get_tree().quit()
