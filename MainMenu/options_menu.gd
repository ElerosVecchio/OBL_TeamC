extends Node2D


var music_volume_label : Label
var sound_volume_label : Label


func _ready():
	# Assign labels from scene
	music_volume_label = get_node("CanvasLayer/label_music_volume")
	sound_volume_label = get_node("CanvasLayer/label_sound_volume")


# Placeholder for music volume change functionality
func on_music_volume_changed(value):
	music_volume_label.text = "Music Volume: " + str(int(value))


# Placeholder for sound volume change functionality
func on_sound_volume_changed(value):
	sound_volume_label.text = "Sound Volume: " + str(int(value))


# Placeholder for fullscreen toggle functionality
func on_fullscreen_toggle_changed(checked):
	if checked:
		print("Fullscreen enabled")
	else:
		print("Fullscreen disabled")


# Save and use changed options
func on_save_options_changed():
	print("Changed to new options")
	# open_main_menu()


# Don't save changed options and keep previous
func on_dont_save_options_changed():
	print("Keep previous options")
	# open_main_menu()


# Return to main menu // TODO
func open_main_menu():
	var main_menu_scene = preload("res://MainMenu/main_menu.tscn")
	get_tree().change_scene_to_packed(main_menu_scene)

