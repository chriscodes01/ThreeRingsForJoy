extends Area2D

var fileName = get_script().get_path().get_file()
var itemName = fileName.get_slice(".", 0)
@onready var animation_player = $AnimationPlayer

func _on_body_entered(_body):
	var scene = get_tree().get_current_scene()
	if (scene.name == "CompletionScreen"):
		return
	if (_body.name == "Player"):
		GAMEMANAGER.increment_mergeItem(itemName)
		animation_player.play("pickup")
