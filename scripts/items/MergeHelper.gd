class_name MergeItemsHelper extends Node

# Add helpers when applicable
var preloadedScenes = {
	"ring": preload("res://scenes/items/ring.tscn"),
	"collar": preload("res://scenes/items/collar.tscn"),
	"pup": preload("res://scenes/items/pup.tscn"),
	"kitten": preload("res://scenes/items/kitten.tscn"),
	"bone": preload("res://scenes/items/bone.tscn"),
	"fish": preload("res://scenes/items/fish.tscn"),
	"dog": preload("res://scenes/items/dog.tscn"),
	"cat": preload("res://scenes/items/cat.tscn")
}

var mergeItemProps = {
	"collisionLayer": null,
	"collisionMask": null
}
