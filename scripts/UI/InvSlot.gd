extends Panel

@onready var item_display = $itemDisplay

func update(item):
	if !item:
		item_display.visible = false
	else:
		item_display.visible = true
		item_display.texture = item.texture
