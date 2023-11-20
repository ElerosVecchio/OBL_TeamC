extends Node2D


@onready var tree = get_tree()

# Placeholder for quit button functionality
func on_quit_button_pressed():
	print("QUIT button pressed.")
	# tree.quit()


# Placeholder for options button functionality
func on_options_button_pressed():
	print("OPTIONS button pressed.")
	open_options_menu()


# Open options menu
func open_options_menu():
	var options_menu_scene = preload("res://MainMenu/options_menu.tscn")
	tree.change_scene_to_packed(options_menu_scene)


# Finished play button
func _on_btn_play_pressed():
	print("PLAY button pressed.")
	var world_scene = preload("res://TurnBasedSystem&Scene/world.tscn")
	get_tree().change_scene_to_packed(world_scene)
