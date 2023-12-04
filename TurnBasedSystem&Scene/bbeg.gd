extends CharacterBody2D

var not_idle = false

func _physics_process(delta):
	bbeg_animations()
	update_bbeghealth()
	$AnimatedSprite2D.flip_h = true
	bbegattacking()
	defeat()
	
func bbeg_animations():
	if not_idle == false:
		$AnimatedSprite2D.play('evil_idle')

func update_bbeghealth():
	var healthbar = $healthbar
	healthbar.max_value = Global.bbegmaxhealth
	healthbar.value = Global.bbegcurrenthealth
	healthbar.get_node("Label").text = "HP: %d/%d" % [Global.bbegcurrenthealth, Global.bbegmaxhealth]

func bbegattacking():
	if Global.enemyturn == true:
		#Global.bbegattacking = true
		not_idle = true
		$AnimatedSprite2D.play('evil_attack')
		await $AnimatedSprite2D.animation_finished
		not_idle = false
		Global.enemyturn = false
		Global.playerturn = true
		
func defeat():
	if Global.bbegcurrenthealth <= 0:
		Global.bbegdefeated = true
		$healthbar.hide()
		not_idle = true
		$AnimatedSprite2D.play('evil_death')
		await $AnimatedSprite2D.animation_finished
		get_tree().change_scene_to_file("res://MainMenu/main_menu.tscn")
