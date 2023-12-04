extends Node

var current_scene = "walking_map"
var transition_scene = false

var player_exit_posx = 0
var player_exit_posy = 0
var player_start_posx = 0
var player_start_posy = 0

func finish_changescenes():
	if transition_scene == true:
		transition_scene = false
		if current_scene == "walking_map":
			current_scene = "world"
		else:
			current_scene = "world"
