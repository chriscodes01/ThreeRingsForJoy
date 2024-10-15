extends Node2D

# THIS SCRIPT HANDLES GLOBAL UI LOGIC
var time

const FILE_BEGIN = "res://scenes/environment/"
const EXTENSION = ".tscn"
const COMPLETIONMAP = "CompletionMap"
const COMPLETIONMUSICSTREAM = "res://assets/audio/CompletionMusic.mp3"
const TUTORIALMAP = "Tutorial"
var rng = RandomNumberGenerator.new()
var CURRENTMAP = null
var MAPNAME = null
var rootScene = null
const XAXISBUFFER = 100
const YAXISBUFFER = 150
const XAXISBUFFERITEMS = 100
const YAXISBUFFERITEMS = 100

func _ready():
	rootScene = get_tree().get_current_scene()
	var tileMapList = rootScene.find_children("*", "TileMap")
	if (tileMapList.is_empty()):
		return
	if ((tileMapList[0].name == "MainMenuScreen") || (tileMapList[0].name == "CompletionMap")):
		return
	CURRENTMAP = tileMapList[0]
	MAPNAME = CURRENTMAP.name
	var map = MERGEMAP.maps[MAPNAME]
	spawnFromMergeMap()
	changeViewportLimits()
	start_timer(map.time)
	
func _process(_delta):
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
	pause_timer()
	rootScene = get_tree().get_current_scene()
	var tileMapList = rootScene.find_children("*", "TileMap")
	var scene_transition_animation = rootScene.find_child("BannerTransition")
	var animationPlayer = scene_transition_animation.find_child("AnimationPlayer")
	hidePlayer()
	resetPlayer()
	animationPlayer.play("fade_in")
	print("fade in")
	get_tree().paused = true
	var currentMap = tileMapList[0]
	var mapList = MERGEMAP.maps.keys()
	mapList.erase(currentMap.name)
	mapList.erase(TUTORIALMAP)
	if (currentMap.name == TUTORIALMAP):
		GAMEMANAGER.resetInventory()
		var teleporter = get_tree().get_current_scene().get_node("TempNextLevelPortal")
		teleporter.queue_free()
	var nextMap = mapList.pick_random()
	currentMap.free()
	
	var nextLevelPath = FILE_BEGIN + nextMap + EXTENSION
	var nextLevel = load(nextLevelPath).instantiate()
	despawnMergeItems()
	await get_tree().create_timer(1).timeout
	rootScene.add_child(nextLevel, true)
	nextLevel.set_owner(rootScene)
	CURRENTMAP = nextLevel
	changeViewportLimits()
	spawnFromMergeMap()
	animationPlayer.play("fade_out")
	print("fade out")
	await get_tree().create_timer(1).timeout
	randomlyMovePlayer()
	showPlayer()
	get_tree().paused = false
	start_timer(MERGEMAP.maps[nextMap].time)
	var tile_rect = CURRENTMAP.get_used_rect()
	#var topLeft = $Prototype.map_to_local(tile_rect.position)
	var size = CURRENTMAP.map_to_local(tile_rect.size)
	
func changeViewportLimits():
	var tile_rect = CURRENTMAP.get_used_rect()
	var size = CURRENTMAP.map_to_local(tile_rect.size)
	var xAxisLengthFromCenter = size[0] / 2 - XAXISBUFFER
	var yAxis = size[1] - YAXISBUFFER
	var bottom = 50
	var top = -yAxis
	var left = -xAxisLengthFromCenter
	var right = xAxisLengthFromCenter
	var camera = get_tree().get_current_scene().get_node("Player/PlayerCamera")
	camera.limit_bottom = bottom
	camera.limit_top = top
	camera.limit_left = left
	camera.limit_right = right

func togglePause():
	var pause_menu = get_tree().get_current_scene().get_node("Player/PlayerCamera/CanvasLayer/PauseMenu")
	if get_tree().paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		get_tree().paused = false
		pause_menu.hide()
		unpause_timer()
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
		pause_menu.show()
		pause_timer()

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
	var spawned_items = get_tree().get_current_scene().find_child("SpawnedItems")
	if (!spawned_items):
		return
	if (!rootScene):
		rootScene = get_tree().get_current_scene()
	var tileMapList = rootScene.find_children("*", "TileMap")
	CURRENTMAP = tileMapList[0]
	MAPNAME = CURRENTMAP.name
	var map = MERGEMAP.maps[MAPNAME]
	var mergeItems = map["mergeItems"]
	for item in mergeItems:
		var itemObj = mergeItems[item]
		spawnMergeItems(item, itemObj, spawned_items)

func start_timer(time):
	var current_scene = get_tree().get_current_scene()
	var timer = current_scene.find_child("MapTimer")
	if (!timer):
		return
	timer.paused = false
	timer.wait_time = time
	timer.start()

func pause_timer():
	var current_scene = get_tree().get_current_scene()
	var timer = current_scene.find_child("MapTimer")
	timer.paused = true
	
func unpause_timer():
	var current_scene = get_tree().get_current_scene()
	var timer = current_scene.find_child("MapTimer")
	timer.paused = false

func _on_timer_timeout():
	changeMap()
	
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
	var xAxisLengthFromCenter = size[0] / 2 - XAXISBUFFER - XAXISBUFFERITEMS
	#var yAxisLengthFromCenter = size[1] / 2 - YAXISBUFFER
	var yAxis = size[1] - YAXISBUFFER - YAXISBUFFERITEMS
	var leftOrRight = randi_range(0,1)
	if (leftOrRight == 0):
		object.position = Vector2(randi_range(10, xAxisLengthFromCenter), randi_range(0, -yAxis))
	else:
		object.position = Vector2(randi_range(-xAxisLengthFromCenter, -10), randi_range(0, -yAxis))

func get_time():
	var current_scene = get_tree().get_current_scene()
	var timer = current_scene.find_child("MapTimer")
	return timer.time_left

func time_to_string() -> String:
	var time = get_time()
	var mili = fmod(time, 1) * 1000
	var sec = fmod(time, 60)
	var min = time / 60
	var format_string = "%02d : %02d : %02d"
	var actual_string = format_string % [min, sec, mili]
	return actual_string

func showCompletionScreen():
	rootScene = get_tree().get_current_scene()
	var tileMapList = rootScene.find_children("*", "TileMap")
	var scene_transition_animation = rootScene.find_child("CompletionTransition")
	var animationPlayer = scene_transition_animation.find_child("AnimationPlayer")
	var currentMap = tileMapList[0]
		
	animationPlayer.play("fade_in")
	hideGameUI()
	#cameraZoomOut()
	pause_timer()
	hidePlayer()
	resetPlayer()
	#get_tree().paused = true
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scenes/UI/CompletionScreen.tscn")
	#playCompletionMusic()
	#animationPlayer.play("fade_in")
	#if (tileMapList.is_empty()):
		#return
	#var nextLevelPath = FILE_BEGIN + nextMap + EXTENSION
	#var nextLevel = load(nextLevelPath).instantiate()
	#despawnMergeItems()
	#await get_tree().create_timer(.5).timeout
	##rootScene.add_child(nextLevel, true)
	##nextLevel.set_owner(rootScene)
	#animationPlayer.play("fade_out")
	#await get_tree().create_timer(.5).timeout
	##showPlayer()
	#get_tree().paused = false
	#Input.action_press("jump")

func playCompletionMusic():
	var musicPlayer = get_tree().get_current_scene().find_child("MusicPlayer")
	var completionMusic = load(COMPLETIONMUSICSTREAM)
	#rootScene.add_child(nextLevel, true)
	#nextLevel.set_owner(rootScene)
	musicPlayer.stream = completionMusic
	musicPlayer.play()

func resetPlayer():
	if (!rootScene):
		rootScene = get_tree().get_current_scene()
	var player = rootScene.find_child("Player").find_child("Player")
	player.position = Vector2(0, 0)
	
func hideGameUI():
	var canvasLayer = get_tree().get_current_scene().get_node("Player/PlayerCamera/CanvasLayer")
	var stopwatch_label = canvasLayer.find_child("StopwatchLabel")
	var timer_warning = canvasLayer.find_child("TimerWarning")
	stopwatch_label.visible = false
	timer_warning.visible = false
	
func cameraZoomOut():
	var camera = get_tree().get_current_scene().get_node("Player/PlayerCamera")
	camera.zoom = Vector2(1,1)
