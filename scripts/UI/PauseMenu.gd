extends Control

var pauseInput

func _physics_process(_delta):
	pauseInput = Input.is_action_just_pressed("pause")

func _on_resume_pressed():
	GAMEMAIN.togglePause()

func _on_quit_pressed():
	get_tree().quit()

func _on_return_to_main_menu_pressed():
	GAMEMAIN.togglePause()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://scenes/UI/MainMenu.tscn")
