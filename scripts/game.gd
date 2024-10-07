extends Node2D

# THIS SCRIPT HANDLES GLOBAL UI LOGIC
@onready var scene_transition_animation = $BannerTransition/AnimationPlayer
@onready var pause_menu = $Player/PlayerCamera/CanvasLayer/PauseMenu

const FILE_BEGIN = "res://scenes/environment/"
const EXTENSION = ".tscn"
var rng = RandomNumberGenerator.new()
var CURRENTMAP = null
var MAPNAME = null
var rootScene = null
const XAXISBUFFER = 25
const YAXISBUFFER = 275

func _ready():
	var a = get_tree().get_current_scene()
	rootScene = get_tree().get_current_scene()
	var tileMapList = rootScene.find_children("*", "TileMap")
	if (tileMapList.is_empty()):
		return
	CURRENTMAP = tileMapList[0]
	MAPNAME = CURRENTMAP.name
	spawnFromMergeMap()
	
func _process(delta):
	var current_scene = get_tree().get_current_scene()
	if (!current_scene):
		return
	var spawned_items = current_scene.find_child("SpawnedItems")
	if (!spawned_items):
		return
	var spawnedItems = spawned_items.get_children()
	for item in spawnedItems:
		if (item.has_overlapping_bodies()):
			if (!CURRENTMAP):
				if (!rootScene):
					rootScene = get_tree().get_current_scene()
				var tileMapList = rootScene.find_children("*", "TileMap")
				CURRENTMAP = tileMapList[0]
			randomizeObjectPosition(item)
			#var tile_rect = CURRENTMAP.get_used_rect()
			##var topLeft = $Prototype.map_to_local(tile_rect.position)
			#var size = CURRENTMAP.map_to_local(tile_rect.size)
			#var xAxisLengthFromCenter = size[0] / 2 - XAXISBUFFER
			##var yAxisLengthFromCenter = size[1] / 2 - YAXISBUFFER
			#var yAxis = size[1] - YAXISBUFFER
			#var leftOrRight = randi_range(0,1)
			#if (leftOrRight == 0):
				#item.position = Vector2(randi_range(10, xAxisLengthFromCenter), randi_range(0, -yAxis))
			#else:
				#item.position = Vector2(randi_range(-xAxisLengthFromCenter, -10), randi_range(0, -yAxis))

func changeMap():
	print("Entered portal")
	var rootScene = get_tree().get_current_scene()
	var tileMapList = rootScene.find_children("*", "TileMap")
	scene_transition_animation = rootScene.find_child("BannerTransition")
	var animationPlayer = scene_transition_animation.find_child("AnimationPlayer")
	animationPlayer.play("fade_in")
	hidePlayer()
	get_tree().paused = true
	var currentMap = tileMapList[0]
	var mapList = MERGEMAP.maps.keys()
	mapList.erase(str(currentMap.name))
	var nextMap = mapList.pick_random()
	currentMap.free()
	
	var nextLevelPath = FILE_BEGIN + nextMap + EXTENSION
	var nextLevel = load(nextLevelPath).instantiate()
	despawnMergeItems()
	await get_tree().create_timer(1.2).timeout
	rootScene.add_child(nextLevel, true)
	nextLevel.set_owner(rootScene)
	spawnFromMergeMap()
	animationPlayer.play("fade_out")
	await get_tree().create_timer(1.2).timeout
	randomlyMovePlayer()
	showPlayer()
	get_tree().paused = false

func togglePause():
	print("togglePause")
	if(!pause_menu):
		pause_menu = get_tree().get_current_scene().get_node("Player/PlayerCamera/CanvasLayer/PauseMenu")
	if get_tree().paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		get_tree().paused = false
		pause_menu.hide()
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
		pause_menu.show()

func randomlyMovePlayer():
	if (!rootScene):
		rootScene = get_tree().get_current_scene()
	var player = rootScene.find_child("Player").find_child("Player")
	var tileMapList = rootScene.find_children("*", "TileMap")
	CURRENTMAP = tileMapList[0]
	randomizeObjectPosition(player)

func hidePlayer():
	if (!rootScene):
		rootScene = get_tree().get_current_scene()
	var player = rootScene.find_child("Player").find_child("Player")
	player.hide()
	
func showPlayer():
	if (!rootScene):
		rootScene = get_tree().get_current_scene()
	var player = rootScene.find_child("Player").find_child("Player")
	player.show()

func despawnMergeItems():
		var spawned_items = get_tree().get_current_scene().find_child("SpawnedItems")
		var children = spawned_items.get_children()
		for child in children:
			child.free()

func spawnFromMergeMap():
	if (!rootScene):
		rootScene = get_tree().get_current_scene()
	var tileMapList = rootScene.find_children("*", "TileMap")
	CURRENTMAP = tileMapList[0]
	MAPNAME = CURRENTMAP.name
	var map = MERGEMAP.maps[MAPNAME]
	var mergeItems = map["mergeItems"]
	for item in mergeItems:
		var itemObj = mergeItems[item]
		var spawned_items = get_tree().get_current_scene().find_child("SpawnedItems")
		spawnMergeItems(item, itemObj, spawned_items)

func spawnMergeItems(itemName, itemObj, spawned_items):
	var amountToSpawn = itemObj["count"]
	for count in amountToSpawn:
		var itemToSpawn = MERGEHELPER.preloadedScenes[itemName].instantiate()
		#var tile_rect = CURRENTMAP.get_used_rect()
		##var topLeft = $Prototype.map_to_local(tile_rect.position)
		#var size = CURRENTMAP.map_to_local(tile_rect.size)
		#var xAxisLengthFromCenter = size[0] / 2 - XAXISBUFFER
		##var yAxisLengthFromCenter = size[1] / 2 - YAXISBUFFER
		#var yAxis = size[1] - YAXISBUFFER
		#var leftOrRight = randi_range(0,1)
		#if (leftOrRight == 0):
			#itemToSpawn.position = Vector2(randi_range(100, xAxisLengthFromCenter), randi_range(0, -yAxis))
		#else:
			#itemToSpawn.position = Vector2(randi_range(-xAxisLengthFromCenter, -10), randi_range(0, -yAxis))
		randomizeObjectPosition(itemToSpawn)
		spawned_items.add_child(itemToSpawn, true)
		
func randomizeObjectPosition(object):
	var tile_rect = CURRENTMAP.get_used_rect()
	#var topLeft = $Prototype.map_to_local(tile_rect.position)
	var size = CURRENTMAP.map_to_local(tile_rect.size)
	var xAxisLengthFromCenter = size[0] / 2 - XAXISBUFFER
	#var yAxisLengthFromCenter = size[1] / 2 - YAXISBUFFER
	var yAxis = size[1] - YAXISBUFFER
	var leftOrRight = randi_range(0,1)
	if (leftOrRight == 0):
		object.position = Vector2(randi_range(10, xAxisLengthFromCenter), randi_range(0, -yAxis))
	else:
		object.position = Vector2(randi_range(-xAxisLengthFromCenter, -10), randi_range(0, -yAxis))
