extends Area2D

var itemObj = {
	"level": "Level1",
	"key": "1"
}

func _on_body_entered(_body):
	if (_body.name == "Player"):
		GAMEMANAGER.increment_mergeItem(itemObj)
		queue_free()
