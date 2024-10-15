extends Node2D

# THIS SCRIPT HANDLES GLOBAL BACKEND LOGIC

const MERGEBY = 3
var gameCompleted = false

func _process(delta):
	var itemList = MERGETREELIST.list
	var catCount = itemList["cat"].count
	var dogCount = itemList["dog"].count
	#if ((catCount >= 3) && (dogCount >= 3)):
	if (catCount >= 1 ):
		if (!gameCompleted):
			gameCompleted = true
			GAMEMAIN.showCompletionScreen()

func checkInventory():
	print(MERGETREELIST.list)
	
func resetInventory():
	for item in MERGETREELIST.list:
		var itemObj = MERGETREELIST.list[item]
		itemObj["count"] = 0
	
func increment_mergeItem(itemName):
	var item = MERGETREELIST.list[itemName]
	var levelUp = item["levelUp"]
	var child = item["child"]
	item["count"] += 1
	var canMerge = true if (item["child"] || item["levelUp"]) else false
	if (canMerge):
		determineNextMergePath(item, levelUp, child, item.level)

func determineNextMergePath(item, levelUp, child, _level):
	if (item["count"] == MERGEBY):
		item["count"] = 0
		if (levelUp):
			mergeToNextLevel(levelUp)
		elif (child):
			increment_mergeItem(child)
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
	# get all items from nextLevel
	print("Merging to Next Level..." + nextLevel)
	var baseItemList = []
	for itemKey in MERGETREELIST.list:
		var item = MERGETREELIST.list[itemKey]
		if (item["level"] != nextLevel):
			continue
		var baseItem = false if item["parent"] else true
		if (baseItem):
			baseItemList.append(item)
	if (!baseItemList.is_empty()):
		var chosenBaseItem = baseItemList.pick_random()
		var chosenBaseItemName = MERGETREELIST.list.find_key(chosenBaseItem)
		print("Randomly choose... " + chosenBaseItemName)
		increment_mergeItem(chosenBaseItemName)

#func increment_mergeItem(itemObj):
	#print("ItemKey: " + itemObj.key + "; ItemLevel: " + str(itemObj.level))
	#var levelObj = MERGETREELIST.list[itemObj.level]
	#var item = levelObj[itemObj.key]
	#var levelUp = item["levelUp"]
	#var childKey = item["childKey"]
	#item["count"] += 1
	##print(levelObj)
	#var canMerge = true if (item["childKey"] || item["levelUp"]) else false
	#if (canMerge):
		#determineNextMergePath(item, levelUp, childKey, itemObj.level)
#
#func determineNextMergePath(item, levelUp, childKey, level):
	#if (item["count"] == MERGEBY):
		#item["count"] = 0
		#if (levelUp):
			#mergeToNextLevel(levelUp)
		#elif (childKey):
			#print(childKey)
			#var nextItemObj = {
				#"level": level,
				#"key": childKey
			#}
			#increment_mergeItem(nextItemObj)
	#elif (item["count"] > MERGEBY):
		## 5 / 3 = 1 r2
		## var answer rounded down = 1
		## count - answer * 3 = 2
		## remainder = 2
		## item["count"] = 2
		## for i of remainder:
			## merge to next level
		##var multipleMergeCount = item["count"] / MERGEBY
		#pass
#
#func mergeToNextLevel(nextLevel):
	#var levelObj = MERGETREELIST.list[nextLevel]
	#print("Merging to Next Level...")
	#var baseItemList = []
	#for itemKey in levelObj:
		#var item = levelObj[itemKey]
		#var baseItem = false if item["parentKey"] else true
		#if (baseItem):
			#print(item["name"])
			#baseItemList.append(item)
	#if (!baseItemList.is_empty()):
		#var chosenBaseItem = baseItemList.pick_random()
		#print("Randomly choose... " + chosenBaseItem["name"])
		#var chosenBaseItemKey = levelObj.find_key(chosenBaseItem)
		#var currentItemObj = {
			#"level": nextLevel,
			#"key": chosenBaseItemKey
		#}
		#increment_mergeItem(currentItemObj)
