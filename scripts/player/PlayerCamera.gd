extends Camera2D
const XAXISBUFFER = 100
const YAXISBUFFER = 150
const XAXISBUFFERITEMS = 100
const YAXISBUFFERITEMS = 100
@onready var player = $"../Player"

func _physics_process(_delta):
	var cameraLocked = true if get_tree().get_current_scene().find_child("CompletionMap") else false
	if (!cameraLocked):
		position = player.position
	else:
		position = Vector2(0,0)
