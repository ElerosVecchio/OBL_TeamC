extends Node2D

var itemData = {} # dictionary with data from the items table
var item_rarity_distribution = {"Common": 70, "Uncommon": 25, "Rare": 5}
var item_stats = ["Attack", "Defense", "Health Regen"]
var item_scaling_stats = ["Attack", "Defense", "Health Regen"]

func load():
	var itemDataFile = FileAccess.open("res://Item scripts/OBL Item Data Sheet - Sheet1.json", FileAccess.READ)
	var itemDataJSON = JSON.new()
	itemDataJSON.parse(itemDataFile.get_as_text())
	var item_data = itemDataJSON.get_data()
	itemDataFile.close()
	itemData = itemDataJSON.result
	
# Called when the node enters the scene tree for the first time.
func _ready():
	print(load("res://Item scripts/OBL Item Data Sheet - Sheet1.json"))
	print(itemData)



