extends Control

var pauseInput

func _physics_process(_delta):
	pauseInput = Input.is_action_just_pressed("pause")
	# This will toggle twice because it's being called from both player.gd and this script
	#if (pauseInput):
		#GAMEMAIN.togglePause()

func _on_resume_pressed():
	GAMEMAIN.togglePause()

func _on_quit_pressed():
	get_tree().quit()
