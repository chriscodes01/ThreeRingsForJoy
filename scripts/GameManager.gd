extends Node2D

var ringScene = preload("res://scenes/items/ring.tscn")
#var rng = RandomNumberGenerator.new()
var MERGEBY = 3

func checkInventory():
	print(MERGETREELIST.list)

func increment_mergeItem(itemObj):
	print("ItemKey: " + itemObj.key + "; ItemLevel: " + str(itemObj.level))
	var levelObj = MERGETREELIST.list[itemObj.level]
	var item = levelObj[itemObj.key]
	var levelUp = item["levelUp"]
	var childKey = item["childKey"]
	item["count"] += 1
	#print(levelObj)
	var canMerge = true if (item["childKey"] || item["levelUp"]) else false
	if (canMerge):
		determineNextMergePath(item, levelUp, childKey, itemObj.level)

func determineNextMergePath(item, levelUp, childKey, level):
	if (item["count"] == MERGEBY):
		item["count"] = 0
		if (levelUp):
			mergeToNextLevel(levelUp)
		elif (childKey):
			print(childKey)
			var nextItemObj = {
				"level": level,
				"key": childKey
			}
			increment_mergeItem(nextItemObj)
	elif (item["count"] > MERGEBY):
		# 5 / 3 = 1 r2
		# var answer rounded down = 1
		# count - answer * 3 = 2
		# remainder = 2
		# item["count"] = 2
		# for i of remainder:
			# merge to next level
		#var multipleMergeCount = item["count"] / MERGEBY
		pass

func mergeToNextLevel(nextLevel):
	var levelObj = MERGETREELIST.list[nextLevel]
	print("Merging to Next Level...")
	var baseItemList = []
	for itemKey in levelObj:
		var item = levelObj[itemKey]
		var baseItem = false if item["parentKey"] else true
		if (baseItem):
			print(item["name"])
			baseItemList.append(item)
	if (!baseItemList.is_empty()):
		var chosenBaseItem = baseItemList.pick_random()
		print("Randomly choose... " + chosenBaseItem["name"])
		var chosenBaseItemKey = levelObj.find_key(chosenBaseItem)
		var currentItemObj = {
			"level": nextLevel,
			"key": chosenBaseItemKey
		}
		increment_mergeItem(currentItemObj)
