extends Node2D

@onready var pause_menu = $Player/PlayerCamera/CanvasLayer/PauseMenu
@onready var spawned_items = get_tree().get_current_scene().find_child("SpawnedItems")

var rng = RandomNumberGenerator.new()
var CURRENTMAP = null
var MAPNAME = null
var rootScene = null
const XAXISBUFFER = 25
const YAXISBUFFER = 40

func _ready():
	var a = get_tree().get_current_scene()
	rootScene = get_tree().get_current_scene()
	var tileMapList = rootScene.find_children("*", "TileMap")
	CURRENTMAP = tileMapList[0]
	MAPNAME = CURRENTMAP.name
	spawnFromMergeMap()
	pass
	
func _process(delta):
	var pauseInput = Input.is_action_just_pressed("pause")
	if (pauseInput):
		togglePause()
	var spawnedItems = spawned_items.get_children()
	for item in spawnedItems:
		if (item.has_overlapping_bodies()):
			if (!CURRENTMAP):
				var tileMapList = rootScene.find_children("*", "TileMap")
				CURRENTMAP = tileMapList[0]
			var tile_rect = CURRENTMAP.get_used_rect()
			#var topLeft = $Prototype.map_to_local(tile_rect.position)
			var size = CURRENTMAP.map_to_local(tile_rect.size)
			var xAxisLengthFromCenter = size[0] / 2 - XAXISBUFFER
			#var yAxisLengthFromCenter = size[1] / 2 - YAXISBUFFER
			var yAxis = size[1] - YAXISBUFFER
			var leftOrRight = randi_range(0,1)
			if (leftOrRight == 0):
				item.position = Vector2(randi_range(10, xAxisLengthFromCenter), randi_range(0, -yAxis))
			else:
				item.position = Vector2(randi_range(-xAxisLengthFromCenter, -10), randi_range(0, -yAxis))

func togglePause():
	if get_tree().paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		get_tree().paused = false
		pause_menu.hide()
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
		pause_menu.show()
		
func despawnMergeItems():
		var children = spawned_items.get_children()
		for child in children:
			child.free()

func spawnFromMergeMap():
	var tileMapList = rootScene.find_children("*", "TileMap")
	CURRENTMAP = tileMapList[0]
	MAPNAME = CURRENTMAP.name
	var map = MERGEMAP.maps[MAPNAME]
	var mergeItems = map["mergeItems"]
	for item in mergeItems:
		var itemObj = mergeItems[item]
		spawnMergeItems(item, itemObj)

func spawnMergeItems(itemName, itemObj):
	var amountToSpawn = itemObj["count"]
	for count in amountToSpawn:
		var itemToSpawn = MERGEHELPER.preloadedScenes[itemName].instantiate()
		var tile_rect = CURRENTMAP.get_used_rect()
		#var topLeft = $Prototype.map_to_local(tile_rect.position)
		var size = CURRENTMAP.map_to_local(tile_rect.size)
		var xAxisLengthFromCenter = size[0] / 2 - XAXISBUFFER
		#var yAxisLengthFromCenter = size[1] / 2 - YAXISBUFFER
		var yAxis = size[1] - YAXISBUFFER
		var leftOrRight = randi_range(0,1)
		if (leftOrRight == 0):
			itemToSpawn.position = Vector2(randi_range(100, xAxisLengthFromCenter), randi_range(0, -yAxis))
		else:
			itemToSpawn.position = Vector2(randi_range(-xAxisLengthFromCenter, -10), randi_range(0, -yAxis))
		spawned_items.add_child(itemToSpawn, true)
