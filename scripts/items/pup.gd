extends Area2D

var fileName = get_script().get_path().get_file()
var itemName = fileName.get_slice(".", 0)

func _on_body_entered(_body):
	if (_body.name == "Player"):
		GAMEMANAGER.increment_mergeItem(itemName)
		queue_free()
