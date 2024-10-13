extends Label

func _process(delta):
	update_stopwatch_label()
	
func update_stopwatch_label():
	text = GAMEMAIN.time_to_string()
