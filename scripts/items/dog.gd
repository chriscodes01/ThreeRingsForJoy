extends Area2D

var itemObj = {
	"level": "Level3",
	"key": "0"
}

func _on_body_entered(_body):
	GAMEMANAGER.increment_mergeItem(itemObj)
	queue_free()
