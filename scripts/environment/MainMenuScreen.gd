extends TileMap

@onready var timer = $Timer
@onready var cat = $DefaultItems/Cat
@onready var dog = $DefaultItems/Dog
@onready var pup = $DefaultItems/Pup
@onready var kitten = $DefaultItems/Kitten

func moveRight():
	var petToMove = randi_range(1,4)
	if (petToMove == 1):
		kitten.position[0] += 4
	elif (petToMove == 2):
		cat.position[0] += 3
	elif (petToMove == 3):
		dog.position[0] += 3
	elif (petToMove == 4):
		pup.position[0] += 4
	else:
		cat.position[0] += 3
		dog.position[0] += 3
		pup.position[0] += 4
		kitten.position[0] += 4

func moveLeft():
	var petToMove = randi_range(1,4)
	if (petToMove == 1):
		kitten.position[0] -= 4
	elif (petToMove == 2):
		cat.position[0] -= 3
	elif (petToMove == 3):
		dog.position[0] -= 3
	elif (petToMove == 4):
		pup.position[0] -= 4
	else:
		cat.position[0] -= 3
		dog.position[0] -= 3
		pup.position[0] -= 4
		kitten.position[0] -= 4

func _on_timer_timeout():
	var leftOrRight = randi_range(0,1)
	if (leftOrRight == 0):
		moveRight()
	else:
		moveLeft()
