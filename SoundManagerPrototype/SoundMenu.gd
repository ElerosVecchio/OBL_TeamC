extends Control

# Preparing sound buses (each "bus" allows for adjusting volumes separately)
# One "bus" (audio stream) for music, one for audio
var music_bus = AudioServer.get_bus_index("Music")
var sound_effects_bus = AudioServer.get_bus_index("SoundEffects")

# Preparing each individual sound effect
@onready var sound_effect_one = $sound_effect_one
@onready var sound_effect_two = $sound_effect_two
# Continue this pattern for remaining sound effects, and
# change variable names as needed. 
# For each sound effect in the scene, go to the inspector
# and make sure that "bus" is set to SoundEffects
# Only the main music loop is set to Master


# Background music volume
func _on_v_slider_value_changed(value):
	AudioServer.set_bus_volume_db(music_bus, (value))
	if value == -30:
		AudioServer.set_bus_mute(music_bus, true)
	else:
		AudioServer.set_bus_mute(music_bus, false)

# Sound effects volume
func _on_slider_value_changed(value):
	AudioServer.set_bus_volume_db(sound_effects_bus, (value))
	if value == -30:
		AudioServer.set_bus_mute(sound_effects_bus, true)
	else:
		AudioServer.set_bus_mute(sound_effects_bus, false)
		

# Triggers (for each one, use this format, just connect a function to this script)
func _on_test_button_one_button_down():
	sound_effect_one.play()


func _on_test_button_one_2_button_down():
	sound_effect_two.play()
