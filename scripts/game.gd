extends Node2D

@onready var pause_menu = $Player/PlayerCamera/CanvasLayer/PauseMenu
@onready var spawned_items = $SpawnedItems

var rng = RandomNumberGenerator.new()
const MAPKEY = "0"
const XAXISBUFFER = 25
const YAXISBUFFER = 40
#var paused = false

func _ready():
	spawnFromMergeMap()
	pass
	
func _process(delta):
	var pauseInput = Input.is_action_just_pressed("pause")
	if (pauseInput):
		togglePause()
	var spawnedItems = get_node("SpawnedItems").get_children()
	for item in spawnedItems:
		if (item.has_overlapping_bodies()):
			var tile_rect = $TileMap.get_used_rect()
			#var topLeft = $TileMap.map_to_local(tile_rect.position)
			var size = $TileMap.map_to_local(tile_rect.size)
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

func spawnFromMergeMap():
	var map = MERGEMAP.map[MAPKEY]
	#var mapName = map["name"]
	var mergeItems = map["mergeItems"]
	for item in mergeItems:
		var itemObj = mergeItems[item]
		spawnMergeItems(item, itemObj)

func spawnMergeItems(itemName, itemObj):
	var amountToSpawn = itemObj["count"]
	for count in amountToSpawn:
		var itemToSpawn = MERGEHELPER.preloadedScenes[itemName].instantiate()
		var tile_rect = $TileMap.get_used_rect()
		#var topLeft = $TileMap.map_to_local(tile_rect.position)
		var size = $TileMap.map_to_local(tile_rect.size)
		var xAxisLengthFromCenter = size[0] / 2 - XAXISBUFFER
		#var yAxisLengthFromCenter = size[1] / 2 - YAXISBUFFER
		var yAxis = size[1] - YAXISBUFFER
		var leftOrRight = randi_range(0,1)
		if (leftOrRight == 0):
			itemToSpawn.position = Vector2(randi_range(100, xAxisLengthFromCenter), randi_range(0, -yAxis))
		else:
			itemToSpawn.position = Vector2(randi_range(-xAxisLengthFromCenter, -10), randi_range(0, -yAxis))
		spawned_items.add_child(itemToSpawn)
