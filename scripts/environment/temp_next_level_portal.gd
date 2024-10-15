extends Area2D

const FILE_BEGIN = "res://scenes/environment/"
const EXTENSION = ".tscn"

func _on_body_entered(_body):
	GAMEMAIN.changeMap()
