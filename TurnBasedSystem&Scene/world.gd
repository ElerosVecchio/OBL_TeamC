extends Node2D

var crit = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.playerturn = true
	$AttacksPanel.hide()
	$ItemsPanel.hide()
	$NoMoreAP.hide()
	$EnemyTurnLabel.hide()
	$SurrenderPanel.hide()
	print(Global.actionpoints)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.playerturn == true:
		$ActionsPanel.show()
	defeat()
	victory()
	update_ap()

func _on_attacks_pressed(): #weapons
	$ActionsPanel.hide()
	$AttacksPanel.show()

func _on_defend_pressed(): #items
	$ActionsPanel.hide()
	$ItemsPanel.show()


func _on_exit_attack_pressed():
	$AttacksPanel.hide()
	$ActionsPanel.show()

func _on_lightning_bolt_pressed(): #sword
	if Global.actionpoints >= 2:
		Global.playerattacking = true
		crit = randi() % 100
		if crit <= 50:
			Global.bbegcurrenthealth -= (Global.sworddamage * 1.5)
			print('Critical Hit!')
		else:
			Global.bbegcurrenthealth -= Global.sworddamage
		Global.actionpoints -= 2
	elif Global.actionpoints < 2:
		$NoMoreAP.show()
		

func _on_fireball_pressed(): #lance
	if Global.actionpoints >= 1:
		Global.playerattacking = true
		crit = randi() % 100
		if crit <= 20:
			Global.bbegcurrenthealth -= (Global.lancedamage * 1.5)
			print('Critical Hit!')
		else:
			Global.bbegcurrenthealth -= Global.lancedamage
		Global.actionpoints -= 1
	elif Global.actionpoints < 1:
		$NoMoreAP.show()
		
func _on_icicle_crash_pressed(): #hammer
	if Global.actionpoints >= 4:
		Global.playerattacking = true
		crit = randi() % 100
		if crit <= 65:
			Global.bbegcurrenthealth -= (Global.hammerdamage * 1.5)
			print('Critical Hit!')
		else:
			Global.bbegcurrenthealth -= Global.hammerdamage 
		Global.actionpoints -= 4
	elif Global.actionpoints < 4:
		$NoMoreAP.show()
		
func _on_wand_pressed():
	if Global.actionpoints >= 7:
		Global.playerattacking = true
		Global.bbegcurrenthealth -= Global.wanddamage
		Global.actionpoints -= 7
	elif Global.actionpoints < 7:
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
	$SurrenderPanel.show()
	

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
	crit = randi() % 100
	if Global.bbegcurrenthealth >= Global.bbegmaxhealth * 0.6: #the boss is more likely to crit if it has higher health
		if crit <= 45:
			Global.playercurrenthealth -= Global.bbegdamage * 2 * Global.shielding
			print('Enemy critical hit!')
		else:
			Global.playercurrenthealth -= Global.bbegdamage * Global.shielding
	elif crit <= 20:
		Global.playercurrenthealth -= Global.bbegdamage * 2 * Global.shielding
		print('Enemy critical hit!')
	else:
		Global.playercurrenthealth -= Global.bbegdamage * Global.shielding
	$EnemyTurnLabel.hide()
	Global.shielding = 1
	Global.actionpoints += 2

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

func _on_exit_items_pressed():
	$ItemsPanel.hide()
	$ActionsPanel.show()
	

func _on_health_potion_pressed():
	if Global.healthpotions == 0:
		$NoMoreAP.show()
	else:
		Global.healthpotions -= 1
		if Global.playercurrenthealth >= Global.playermaxhealth * 0.7: #checks if player current health is above 70%
			Global.playercurrenthealth = Global.playermaxhealth
		else:
			Global.playercurrenthealth += Global.playermaxhealth * 0.4


func _on_ap_potion_pressed():
	if Global.appotions == 0:
		$NoMoreAP.show()
	else:
		Global.appotions -= 1
		Global.actionpoints += 2



func _on_damage_potion_pressed():
	if Global.damagepotions == 0:
		$NoMoreAP.show()
	else:
		Global.damagepotions -= 1
		Global.sworddamage += 50
		Global.lancedamage += 50
		Global.hammerdamage += 50
		Global.wanddamage += 50
		Global.shielddamage += 50


func _on_yes_surrender_pressed():
	Global.Surrendering = true

func _on_no_surrender_pressed():
	$SurrenderPanel.hide()
