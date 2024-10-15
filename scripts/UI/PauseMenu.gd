extends Control

var pauseInput

func _physics_process(_delta):
	pauseInput = Input.is_action_just_pressed("pause")

func _on_resume_pressed():
	GAMEMAIN.togglePause()

func _on_quit_pressed():
	get_tree().quit()
