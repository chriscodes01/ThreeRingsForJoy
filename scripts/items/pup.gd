extends Area2D

var itemObj = {
	"level": "Level2",
	"key": "0"
}

func _on_body_entered(_body):
	if (_body.name == "Player"):
		GAMEMANAGER.increment_mergeItem(itemObj)
		queue_free()
