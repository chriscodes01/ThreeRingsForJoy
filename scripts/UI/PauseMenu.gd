extends Control

func _on_resume_pressed():
	GAMEMAIN.togglePause()

func _on_quit_pressed():
	get_tree().quit()
