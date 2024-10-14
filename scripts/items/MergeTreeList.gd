class_name MergeTreeList extends Node2D

var list = {
	"ring": {
		"id": 0,
		"level": "level1",
		"origin": "ring",
		"count": 2,
		"parent": null,
		"child": "collar",
		"levelUp": null
	},
	"collar": {
		"id": 1,
		"level": "level1",
		"origin": "ring",
		"count": 2,
		"parent": "ring",
		"child": null,
		"levelUp": "level2"
	},
	"pup": {
		"id": 4,
		"level": "level2",
		"origin": "pup",
		"count": 0,
		"parent": null,
		"child": "bone",
		"levelUp": null
	},
	"bone": {
		"id": 5,
		"level": "level2",
		"origin": "pup",
		"count": 0,
		"parent": "pup",
		"child": "dog",
		"levelUp": null
	},
	"dog": {
		"id": 6,
		"level": "level2",
		"origin": "pup",
		"count": 0,
		"parent": "bone",
		"child": null,
		"levelUp": null
	},
	"kitten": {
		"id": 8,
		"level": "level2",
		"origin": "kitten",
		"count": 0,
		"parent": null,
		"child": "fish",
		"levelUp": null
	},
	"fish": {
		"id": 9,
		"level": "level2",
		"origin": "kitten",
		"count": 0,
		"parent": "kitten",
		"child": "fish",
		"levelUp": null
	},
	"cat": {
		"id": 10,
		"level": "level2",
		"origin": "kitten",
		"count": 0,
		"parent": "fish",
		"child": null,
		"levelUp": null
	}
}

var listHelper = {
	"ring": list["ring"].id,
	"collar": list["collar"].id,
	"pup": list["pup"].id,
	"bone": list["bone"].id,
	"dog": list["dog"].id,
	"kitten": list["kitten"].id,
	"fish": list["fish"].id,
	"cat": list["cat"].id
}

var oldList = {
	"Level1": {
		"0": {
			"name": "ring",
			"count": 0,
			"parentKey": null,
			"childKey": "1",
			"levelUp": null
		},
		"1": {
			"name": "collar",
			"count": 0,
			"parentKey": "0",
			"childKey": null,
			"levelUp": "Level2"
		},
	},
	"Level2": {
		"0": {
			"name": "pup",
			"count": 0,
			"parentKey": null,
			"childKey": "1",
			"levelUp": null
		},
		"1": {
			"name": "bone",
			"count": 0,
			"parentKey": "0",
			"childKey": null,
			"levelUp": "Level3"
		},
		"2": {
			"name": "kitten",
			"count": 0,
			"parentKey": null,
			"childKey": "3",
			"levelUp": null
		},
		"3": {
			"name": "fish",
			"count": 0,
			"parentKey": "2",
			"childKey": null,
			"levelUp": "Level3"
		},
	},
	"Level3": {
		"0": {
			"name": "dog",
			"count": 0,
			"parentKey": null,
			"childKey": null,
			"levelUp": null
		},
		"1": {
			"name": "cat",
			"count": 0,
			"parentKey": null,
			"childKey": null,
			"levelUp": null
		}
	}
}
