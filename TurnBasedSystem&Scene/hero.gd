extends CharacterBody2D

var not_idle = false

func _physics_process(delta):
	hero_animations()
	update_health()
	attacking()
	defeat()
	
func hero_animations():
	if not_idle == false:
		$AnimatedSprite2D.play('Idle')

func update_health():
	var healthbar = $healthbar
	healthbar.max_value = Global.playermaxhealth
	healthbar.value = Global.playercurrenthealth
	healthbar.get_node("Label").text = "HP: %d/%d" % [Global.playercurrenthealth, Global.playermaxhealth]

func attacking():
	if Global.playerattacking == true:
		not_idle = true
		$AnimatedSprite2D.play('Attack')
		await $AnimatedSprite2D.animation_finished
		Global.playerattacking = false
		not_idle = false
	else:
		pass

func defeat():
	if Global.playercurrenthealth <= 0 or Global.Surrendering == true:
		Global.playerdefeated = true
		$healthbar.hide()
		not_idle = true
		$AnimatedSprite2D.play('Die')
		await $AnimatedSprite2D.animation_finished
		get_tree().quit()
