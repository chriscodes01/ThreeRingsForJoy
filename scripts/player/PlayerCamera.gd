extends Camera2D

@onready var player = $"../Player"

func _physics_process(_delta):
	var cameraLocked = true if get_tree().get_current_scene().find_child("CompletionMap") else false
	if (!cameraLocked):
		position = player.position
