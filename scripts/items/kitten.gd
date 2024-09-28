extends Area2D

var itemObj = {
	"level": "Level2",
	"key": "2"
}

func _on_body_entered(_body):
	GAMEMANAGER.increment_mergeItem(itemObj)
	queue_free()
