extends Camera2D

@onready var player = $"../Player"

func _physics_process(delta):
	position = player.position
