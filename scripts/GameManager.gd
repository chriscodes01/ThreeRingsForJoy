extends Node2D

# THIS SCRIPT HANDLES GLOBAL BACKEND LOGIC

const MERGEBY = 3
var gameCompleted = false

func checkCompletion():
	var itemList = MERGETREELIST.list
	var ringCount = itemList["ring"].count
	var collarCount = itemList["collar"].count
	var boneCount = itemList["bone"].count
	var pupCount = itemList["pup"].count
	var fishCount = itemList["fish"].count
	var kittenCount = itemList["kitten"].count
	var dogCount = itemList["dog"].count
	var catCount = itemList["cat"].count
	if (
		(ringCount >= 3)
		&& (collarCount >= 3)
		&& (boneCount >= 3)
		&& (pupCount >= 3)
		&& (fishCount >= 3)
		&& (kittenCount >= 3)
		&& (dogCount >= 3)
		&& (catCount >= 3)
	):
		if (!gameCompleted):
			gameCompleted = true
			GAMEMAIN.showCompletionScreen()
	
func resetInventory():
	for item in MERGETREELIST.list:
		var itemObj = MERGETREELIST.list[item]
		itemObj["count"] = 0
	
func increment_mergeItem(itemName):
	var item = MERGETREELIST.list[itemName]
	var levelUp = item["levelUp"]
	var child = item["child"]
	item["count"] += 1
	checkCompletion()
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
		increment_mergeItem(chosenBaseItemName)
