extends Node

func _input(event):
	if event.is_action_pressed("ui_accept"):
		ItemGeneration()
		
func ItemGeneration():
	var new_item = {}
	new_item["item_id"] = ItemDetermineType()
	new_item["item_rarity"] = ItemDetermineRarity()
	for i in ImportData.item_stats:
		if ImportData.itemData[new_item["item_id"]][i] != null:
			new_item[i] = ItemDetermineStats(new_item["item_id"], new_item["item_rarity"], i)
	print(new_item)
	
	
func ItemDetermineType():
	var new_item_type
	var item_types = ImportData.itemData.keys()
	randomize()
	new_item_type = item_types[randi() % item_types.size()]
	return new_item_type
	
func ItemDetermineRarity():
	var new_item_rarity
	var item_rarities = ImportData.item_rarity_distribution.keys()
	randomize()
	var rarity_roll = randi() % 100 +1
	for i in item_rarities:
		if rarity_roll <= ImportData.item_rarity_distribution[i]:
			new_item_rarity = i
			break
		else:
			rarity_roll -= ImportData.item_rarity_distribution[i]
		return new_item_rarity
		
func ItemDetermineStats(item_id, rarity, stat):
	var stat_value
	if ImportData.item_scaling_stats.has(stat):
		stat_value = ImportData.ItemData[item_id][stat] * ImportData.item_data[item_id][rarity]
	else:
		stat_value = ImportData.item_data[item_id][stat]
	return stat_value
