extends Control

var invList = MERGETREELIST.list
var invListHelper = MERGETREELIST.listHelper

var is_open = false
#	for itemKey in MERGETREELIST.list:
		#var item = MERGETREELIST.list[itemKey]

# var itemToSpawn = MERGEHELPER.preloadedScenes[itemName].instantiate()
#	spawned_items.add_child(itemToSpawn, true)

func _ready():
	closeInv()
	var slots: Array = $NinePatchRect/GridContainer.get_children()
	for slot in slots:
		var slotKey = (slot.name).right(2)
		var isSingleDigit = true if slotKey.left(1) == "0" else false
		if (isSingleDigit):
			slotKey = slotKey.right(1)
		var itemName = invListHelper.find_key(int(slotKey))
		var nameDisplay = slot.find_child("NameLabel")
		if (itemName != null):
			var itemDisplay = slot.find_child("itemDisplay")
			var itemToDisplay = MERGEHELPER.preloadedScenes[itemName].instantiate()
			itemDisplay.add_child(itemToDisplay, true)
			nameDisplay.text = itemName
		else:
			var countDisplay = slot.find_child("ItemCountLabel")
			countDisplay.visible = false
			nameDisplay.visible = false
	
func update_slots():
	var slots: Array = $NinePatchRect/GridContainer.get_children()
	for slot in slots:
		var slotKey = (slot.name).right(2)
		var isSingleDigit = true if slotKey.left(1) == "0" else false
		if (isSingleDigit):
			slotKey = slotKey.right(1)
		var itemName = invListHelper.find_key(int(slotKey))
		if (itemName != null):
			var itemObj = invList[itemName]
			var countDisplay = slot.find_child("ItemCountLabel")
			countDisplay.text = str(itemObj.count)

func _process(delta):
	update_slots()
	if Input.is_action_just_pressed("openInventory"):
		if is_open:
			closeInv()
		else:
			openInv()

func openInv():
	visible = true
	is_open = true

func closeInv():
	visible = false
	is_open = false
