extends Area2D

var fileName = get_script().get_path().get_file()
var itemName = fileName.get_slice(".", 0)
@onready var animation_player = $AnimationPlayer

func _on_body_entered(_body):
	if (_body.name == "Player"):
		GAMEMANAGER.increment_mergeItem(itemName)
		animation_player.play("pickup")
