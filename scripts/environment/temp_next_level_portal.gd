extends Area2D

const FILE_BEGIN = "res://scenes/environment/"


func _on_body_entered(body):
	print("Entered portal")
	#var tree = get_tree().current_scene.get_path_to()
	#print(tree)
	var currentSceneFile = get_tree().current_scene.scene_file_path
	print(currentSceneFile)
	var nextScene = "temp"
	
	var nextLevelPath = FILE_BEGIN + nextScene
	pass # Replace with function body.
