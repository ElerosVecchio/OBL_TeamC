extends Node2D

var crit = 0
var spec_effect = 0
var can_potion = true

# Called when the node enters the scene tree for the first time.
func _ready():
	can_potion = true
	Global.playerturn = true
	$AttacksPanel.hide()
	$ItemsPanel.hide()
	$NoMoreAP.hide()
	$EnemyTurnLabel.hide()
	$SurrenderPanel.hide()
	$Debuff.hide()
	print(Global.actionpoints)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.playerturn == true:
		$ActionsPanel.show()
	defeat()
	victory()
	update_ap()
	update_hp_potion()
	update_dmg_potion()
	update_ap_potion()
	sword_data()
	lance_data()
	hammer_data()
	wand_data()
	shield_data()
	
func sword_data():
	var sword = $AttacksPanel/AttacksBox/Sword
	sword.text = "Sword\n%d DMG\n2 AP" % [Global.sworddamage]
	
func lance_data():
	var lance = $AttacksPanel/AttacksBox/Lance
	lance.text = "Lance\n%d DMG\n1 AP" % [Global.lancedamage]

func hammer_data():
	var hammer = $AttacksPanel/AttacksBox/Hammer
	hammer.text = "Hammer\n%d DMG\n4 AP" % [Global.hammerdamage]

func wand_data():
	var wand = $AttacksPanel/AttacksBox/Wand
	wand.text = "Wand\n%d DMG\n7 AP" % [Global.wanddamage]
	
func shield_data():
	var shield = $AttacksPanel/AttacksBox/Shield
	shield.text = "Shield\n2x Def\n1 AP" 

	
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
	Global.current_attack = 'Spear'
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
	Global.current_attack = 'Spear'
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
	Global.current_attack = 'Hammer'
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
	Global.current_attack = 'Spear'
	if Global.actionpoints >= 7:
		Global.playerattacking = true
		Global.bbegcurrenthealth -= Global.wanddamage
		Global.actionpoints -= 7
	elif Global.actionpoints < 7:
		$NoMoreAP.show()

func _on_shield_pressed():
	Global.current_attack = 'Hammer'
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

func update_hp_potion():
	var health_potion = $ItemsPanel/Inventory/HealthPotion
	health_potion.text = "HP Potion:%d" % [Global.healthpotions]
	
func update_dmg_potion():
	var damage_potion = $ItemsPanel/Inventory/DamagePotion
	damage_potion.text = "DMG Potion:%d" % [Global.damagepotions]
	
func update_ap_potion():
	var ap_potion = $ItemsPanel/Inventory/APPotion
	ap_potion.text = "AP Potion:%d" % [Global.appotions]

var random_roller = 0 
var debuff_applied = false

func _on_end_turn_pressed():
	var debuff = $Debuff
	debuff_applied = false
	can_potion = true
	Global.enemyturn = true
	Global.playerturn = false
	$ActionsPanel.hide()
	$AttacksPanel.hide()
	$EnemyTurnLabel.show()
	await get_tree().create_timer(2).timeout
	crit = randi() % 100
	spec_effect = randi() % 100
	if Global.bbegcurrenthealth <= Global.bbegmaxhealth * 0.4: #the boss is more likely to crit if it has lower health
		if crit <= 45:
			Global.playercurrenthealth -= Global.bbegdamage * 2 * Global.shielding
			print('Enemy critical hit')
		else:
			Global.playercurrenthealth -= Global.bbegdamage * Global.shielding
		if spec_effect > 66:
			can_potion = false
			debuff.text = "The boss has blocked your potions!"
			debuff_applied = true
		elif spec_effect < 33:
			if Global.actionpoints >= 3:
				Global.actionpoints -= 3
			elif Global.actionpoints == 0:
				Global.actionpoints -= 2
			debuff.text = "The boss has sapped your energy!"
			debuff_applied = true
		if Global.bbegcurrenthealth <= Global.bbegmaxhealth * 0.3:
			Global.bbegcurrenthealth += Global.bbegmaxhealth * 0.025
	else:
		if crit <= 20:
			Global.playercurrenthealth -= Global.bbegdamage * 2 * Global.shielding
			print('Enemy critical hit!')
		else:# no critical hit and boss is too healthy to enter second stage
			Global.playercurrenthealth -= Global.bbegdamage * Global.shielding
		if spec_effect >= 80:
			can_potion = false
			debuff.text = "The boss has blocked your potions!"
			debuff_applied = true
		elif spec_effect <= 20:
			if Global.actionpoints >= 3:
				Global.actionpoints -= 3
			elif Global.actionpoints == 0:
				Global.actionpoints = 0
			debuff.text = "The boss has sapped your energy!"
			debuff_applied = true
		else:
			pass
	$EnemyTurnLabel.hide()
	if debuff_applied == true:
		$Debuff.show()
	Global.shielding = 1
	Global.actionpoints += 2
	if damage_potion_consumed == true:
		Global.sworddamage -= 50
		Global.lancedamage -= 50
		Global.hammerdamage -= 50
		Global.wanddamage -= 50
		Global.shielddamage -= 50
	damage_potion_consumed = false

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
	if can_potion == false:
		$Debuff.show()
	elif Global.healthpotions != 0 and can_potion == true:
		Global.healthpotions -= 1
		if Global.playercurrenthealth >= Global.playermaxhealth * 0.7: #checks if player current health is above 70%
			Global.playercurrenthealth = Global.playermaxhealth
		else:
			Global.playercurrenthealth += Global.playermaxhealth * 0.4


func _on_ap_potion_pressed():
	if Global.appotions == 0:
		$NoMoreAP.show()
	if can_potion == false:
		$Debuff.show()
	elif Global.appotions != 0 and can_potion == true:
		Global.appotions -= 1
		Global.actionpoints += 2

var damage_potion_consumed = false

func _on_damage_potion_pressed():
	if Global.damagepotions == 0:
		$NoMoreAP.show()
	if can_potion == false:
		$Debuff.show()
	elif Global.damagepotions != 0 and can_potion == true:
		damage_potion_consumed = true
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


func _on_debuff_pressed():
	$Debuff.hide()
