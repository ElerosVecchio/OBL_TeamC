extends Node2D


@onready var tree = get_tree()


# Placeholder for play button functionality
func on_play_button_pressed():
	print("PLAY button pressed.")


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

