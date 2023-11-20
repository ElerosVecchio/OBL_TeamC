extends Node2D


var music_volume_label : Label
var sound_volume_label : Label

# Variables used to adjust the audio levels:
var music_bus = AudioServer.get_bus_index("Music")
var sound_effects_bus = AudioServer.get_bus_index("SoundEffects")

var new_music_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
var new_sound_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SoundEffects"))

func _ready():
	# Assign labels from scene
	music_volume_label = get_node("CanvasLayer/label_music_volume")
	sound_volume_label = get_node("CanvasLayer/label_sound_volume")


# Placeholder for music volume change functionality
func on_music_volume_changed(value):
	music_volume_label.text = "Music Volume: " + str(int(value))
	new_music_volume = value*3/10-30 #Value adjusted for technical purposes
	AudioServer.set_bus_volume_db(music_bus, (value*3/10-30))
	


# Placeholder for sound volume change functionality
func on_sound_volume_changed(value):
	sound_volume_label.text = "Sound Volume: " + str(int(value))
	AudioServer.set_bus_volume_db(sound_effects_bus, (value*3/10-30))
	if value == 0:
		AudioServer.set_bus_mute(sound_effects_bus, true)
	else:
		AudioServer.set_bus_mute(sound_effects_bus, false)


# Placeholder for fullscreen toggle functionality
func on_fullscreen_toggle_changed(checked):
	if checked:
		print("Fullscreen enabled")
	else:
		print("Fullscreen disabled")


# Save and use changed options
func on_save_options_changed():
	# Music volume
	AudioServer.set_bus_volume_db(music_bus, new_music_volume)
	if new_music_volume == -30:
		AudioServer.set_bus_mute(music_bus, true)
	else:
		AudioServer.set_bus_mute(music_bus, false)
	
	# Sound volume
	AudioServer.set_bus_volume_db(sound_effects_bus, new_sound_volume)
	if new_sound_volume == -30:
		AudioServer.set_bus_mute(sound_effects_bus, true)
	else:
		AudioServer.set_bus_mute(sound_effects_bus, false)
	
	print("Changed to new options")
	open_main_menu()


# Don't save changed options and keep previous
func on_dont_save_options_changed():
	print("Keep previous options")
	open_main_menu()


# Return to main menu
func open_main_menu():
	get_tree().change_scene_to_file("res://MainMenu/main_menu.tscn")

