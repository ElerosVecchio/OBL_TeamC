extends Node

var actionpoints = 5

var Surrendering = false

var sworddamage = 150
var lancedamage = 70
var hammerdamage = 350
var wanddamage = 650
var shielddamage = 30

var healthpotions = 2
var damagepotions = 1
var appotions = 2
var scrap = 1

var shielding = 1

var bbegdamage = 180

var playermaxhealth = 1500
var playercurrenthealth = 1500

var bbegmaxhealth = 2500
var bbegcurrenthealth = 2500

var playerturn = true
var enemyturn = false

var playerattacking = false
var current_attack = 'Hammer'
var drinkingpotion = false
var current_potion = 'AP Potion'

var bbegdefeated = false
var playerdefeated = false

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reset_game():
	actionpoints = 5
	Surrendering = false
	healthpotions = 2
	damagepotions = 1
	appotions = 2
	scrap = 1
	shielding = 1
	playercurrenthealth = 1500
	bbegcurrenthealth = 2500
	playerturn = true
	enemyturn = false
	playerattacking = false
	current_attack = 'Hammer'
	drinkingpotion = false
	current_potion = 'AP Potion'
	bbegdefeated = false
	playerdefeated = false
