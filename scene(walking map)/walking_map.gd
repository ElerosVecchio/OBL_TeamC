extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Globalscriptscenetransition.current_scene = "walking_map"
	Globalscriptscenetransition.transition_scene = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()
		
func change_scene():
	if Globalscriptscenetransition.transition_scene == true:
		if Globalscriptscenetransition.current_scene == "walking_map":
			get_tree().change_scene_to_file("res://TurnBasedSystem&Scene/world.tscn")
			Globalscriptscenetransition.finish_changescenes()
		

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		Globalscriptscenetransition.transition_scene = true


func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		Globalscriptscenetransition.transition_scene = false
