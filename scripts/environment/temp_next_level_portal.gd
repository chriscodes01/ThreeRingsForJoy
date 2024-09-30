extends Area2D

const FILE_BEGIN = "res://scenes/environment/"
const EXTENSION = ".tscn"


func _on_body_entered(body):
	print("Entered portal")
	#var tree = get_tree().current_scene.get_path_to()
	#print(tree)
	var currentSceneFile = get_tree().current_scene.scene_file_path
	print(currentSceneFile)
	var nextScene = "Prototype2"
	
	var rootScene = get_tree().get_current_scene()
	print(rootScene)
	var tileMapList = rootScene.find_children("*", "TileMap")
	print(tileMapList)
	var currentMap = tileMapList[0]
	currentMap.queue_free()
	
	var nextLevelPath = FILE_BEGIN + nextScene + EXTENSION
	var nextLevel = load(nextLevelPath).instantiate()
	rootScene.add_child(nextLevel, true)
	nextLevel.set_owner(rootScene)
