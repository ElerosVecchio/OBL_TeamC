extends CharacterBody2D

var not_idle = false

func _physics_process(delta):
	hero_animations()
	update_health()
	attacking()
	hurt()
	defeat()
	
func hero_animations():
	if not_idle == false and not Global.enemyturn:
		$AnimatedSprite2D.play('Idle')

func update_health():
	var healthbar = $healthbar
	healthbar.max_value = Global.playermaxhealth
	healthbar.value = Global.playercurrenthealth
	healthbar.get_node("Label").text = "HP: %d/%d" % [Global.playercurrenthealth, Global.playermaxhealth]

func attacking():
	if Global.playerattacking == true:
		not_idle = true
		if Global.current_attack == 'Hammer':
			$AnimatedSprite2D.play('Hammer')
		elif Global.current_attack == 'Spear':
			$AnimatedSprite2D.play('Spear')
		await $AnimatedSprite2D.animation_finished
		Global.playerattacking = false
		not_idle = false
	else:
		pass

func hurt():
	if Global.enemyturn == true:
		$AnimatedSprite2D.play('Hurt')
		await $AnimatedSprite2D.animation_finished
	else:
		pass

func defeat():
	if Global.playercurrenthealth <= 0 or Global.Surrendering == true:
		Global.playerdefeated = true
		$healthbar.hide()
		not_idle = true
		$AnimatedSprite2D.play('Hurt')
		var tween = get_tree().create_tween()
		var tween1 = get_tree().create_tween()
		tween.tween_property(self, "position", position - Vector2(0, -250), 1)
		tween1.tween_property(self, "modulate:a", 0, 0.3)
		await $AnimatedSprite2D.animation_finished
		get_tree().quit()
		
		
