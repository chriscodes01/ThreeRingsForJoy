extends Area2D
@onready var game_manager = %GameManager

var itemObj = {
	"level": "Level2",
	"key": "2"
}

func _on_body_entered(_body):
	game_manager.increment_mergeItem(itemObj)
	queue_free()
