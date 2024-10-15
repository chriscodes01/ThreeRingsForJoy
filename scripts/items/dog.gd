extends Area2D

var fileName = get_script().get_path().get_file()
var itemName = fileName.get_slice(".", 0)

func _on_body_entered(_body):
	var scene = get_tree().get_current_scene()
	if (scene.name == "CompletionScreen"):
		return
	if (_body.name == "Player"):
		GAMEMANAGER.increment_mergeItem(itemName)
		queue_free()
