extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.playerturn = true
	$AttacksPanel.hide()
	$NoMoreAP.hide()
	$EnemyTurnLabel.hide()
	print(Global.actionpoints)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.playerturn == true:
		$ActionsPanel.show()
	defeat()
	victory()
	update_ap()

func _on_attacks_pressed():
	$ActionsPanel.hide()
	$AttacksPanel.show()


func _on_exit_attack_pressed():
	$AttacksPanel.hide()
	$ActionsPanel.show()

func _on_lightning_bolt_pressed(): #sword
	if Global.actionpoints >= 2:
		Global.playerattacking = true
		Global.bbegcurrenthealth -= Global.lightningboltdamage
		Global.actionpoints -= 2
	elif Global.actionpoints < 2:
		$NoMoreAP.show()
		

func _on_fireball_pressed(): #lance
	if Global.actionpoints >= 1:
		Global.playerattacking = true
		Global.bbegcurrenthealth -= Global.fireballdamage
		Global.actionpoints -= 1
	elif Global.actionpoints < 1:
		$NoMoreAP.show()
		
func _on_icicle_crash_pressed(): #hammer
	if Global.actionpoints >= 4:
		Global.playerattacking = true
		Global.bbegcurrenthealth -= Global.iciclecrashdamage
		Global.actionpoints -= 4
	elif Global.actionpoints < 4:
		$NoMoreAP.show()

func _on_shield_pressed():
	if Global.actionpoints >= 1:
		Global.playerattacking = true
		Global.bbegcurrenthealth -= Global.shielddamage
		Global.shielding = 0.5
		Global.actionpoints -= 1
	elif Global.actionpoints < 1:
		$NoMoreAP.show()
	

func _on_no_more_ap_pressed():
	$NoMoreAP.hide()


func _on_surrender_pressed():
	#surrender scene
	get_tree().quit()

func update_ap():
	var APPanel = $APPanel
	APPanel.get_node("Label").text = "AP:%d" % [Global.actionpoints]


func _on_end_turn_pressed():
	Global.enemyturn = true
	Global.playerturn = false
	$ActionsPanel.hide()
	$AttacksPanel.hide()
	$EnemyTurnLabel.show()
	await get_tree().create_timer(2).timeout
	Global.playercurrenthealth -= Global.bbegdamage * Global.shielding
	$EnemyTurnLabel.hide()
	Global.shielding = 0.5
	Global.actionpoints += 1

func defeat():
	if Global.playerdefeated == true:
		$AttacksPanel.hide()
		$ActionsPanel.hide()
		#death scene
		
func victory():
	if Global.bbegdefeated == true:
		$AttacksPanel.hide()
		$ActionsPanel.hide()
		#victory scene


	
	
	
	
		




