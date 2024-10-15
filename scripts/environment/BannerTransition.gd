extends Node2D

@onready var player = $"../Player/Player"


func _physics_process(_delta):
	var cameraLocked = true if get_tree().get_current_scene().find_child("CompletionMap") else false
	if (!cameraLocked):
		if (name == "CompletionTransition"):
			position = player.position - Vector2(700, 50)
		else:
			position = player.position - Vector2(300, 50)
