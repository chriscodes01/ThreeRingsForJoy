class_name MergeTreeList extends Node2D

var list = {
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
