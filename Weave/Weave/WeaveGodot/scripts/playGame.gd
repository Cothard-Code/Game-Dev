extends Node2D

#Variables
var diff = ""
var pause = 0
var score = 0
var scoreTime = 0
var lastWhite = 0
var lastGreen = 0
var lastBlueRed = 0
var lastHeart = 0
var whiteTime = 0
var greenTime = 0
var redTime = 0
var blueTime = 0
var coinTime = 0
var rand = RandomNumberGenerator.new()
var enemyWhiteScene = load("res://scenes/enemies/enemyWhite.tscn")
var enemyWhiteBossScene = load("res://scenes/enemies/enemyWhiteBoss.tscn")
var enemyRedScene = load("res://scenes/enemies/enemyRed.tscn")
var enemyRedBossScene = load("res://scenes/enemies/enemyRedBoss.tscn")
var enemyBlueScene = load("res://scenes/enemies/enemyBlue.tscn")
var enemyGreenScene = load("res://scenes/enemies/enemyGreen.tscn")
var enemyGreenBossScene = load("res://scenes/enemies/enemyGreenBoss.tscn")
var friendlyHeartScene = load("res://scenes/friendlies/friendlyHeart.tscn")
var coinScene = load("res://scenes/friendlies/coin.tscn")
#var shieldScene = load("res://scenes/avatar/shieldAvatar.tscn")
var font
var screen_size
var randSpawn = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport().get_visible_rect().size
	font = load("res://fonts/weaveFont.tres")
	font.size = 35
	diff = Globals.difficulty
	draw()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	draw()
	randSpawn.randomize()
	lastWhite += 1

	lastGreen += 1
	lastBlueRed += 1
	lastHeart += 2
	
	if Input.is_action_pressed("play"):
		Globals.move = 1
	else:
		Globals.move = 0
	if Globals.move == 1:
		scoreTime += 1
		if(scoreTime % 10 == 0):
			score += 1
	if (Input.is_action_just_pressed("scoreBoost")):
		score += 100
	if (Input.is_action_just_pressed("getCoins")):
		Globals.coins += 5
#	if (Input.is_action_just_pressed("skipLevel")):
#		Globals.level += 1
#		score = 0
#		get_node("CanvasLayer/player_health").get_stylebox("fg").set_bg_color(Color((100.0 - Globals.health)/100, (Globals.health/100.0), 0)) 
#		get_tree().reload_current_scene()

	if((diff == "easy") && (pause == 0)):
		## Create Friendlies
		if((rand_range(0, 2000 - score - lastHeart)) < 1):
			createHeart()
		coinTime += 1
		if(coinTime == 300):
			createCoin()
			coinTime = 0
		
		whiteTime += 1
		if(whiteTime == 60 - (int(Globals.level)%6)*5):
			createWhite()
			whiteTime = 0
		if(Globals.level == 6): #Boss White
			if((rand_range(0, 175 - score/2 - lastWhite)) < 1):
				createWhite()
			if((rand_range(0, 150 - score - lastWhite)) < 1):
				createWhiteBoss()
		if(Globals.level >= 7):
			greenTime += 1
			if(greenTime == 120 - (int(Globals.level)%6)*5):
				createGreen()
				greenTime = 0
			if(Globals.level == 12): #Boss Green
				if((rand_range(0, 200 - score/15 - lastGreen)) < 1):
					createGreen()
				if((rand_range(0, 150 - score/5 - lastGreen)) < 1):
					createGreenBoss()
		if(Globals.level >= 13):
			blueTime += 1
			if(blueTime == 150 - (int(Globals.level)%6)*5):
				createBlue()
				blueTime = 0
			#if(Globals.level == 18): #Boss Blue
				#BlueBoss
		if(Globals.level >= 18):
			redTime += 1
			if(redTime == 175 - (int(Globals.level)%6)*5):
				createRed()
				redTime = 0
			if(Globals.level == 24): #Boss Green
				if((rand_range(0, 150 - score/5 - lastBlueRed)) < 1):
					createRedBoss()

		if(score >= 100):
			levelComplete()
		if(Globals.health <= 0):
			defeat()

	if(diff == "medium"):
		if((rand_range(0, 150 - score/10)) < 1):
			createWhite()
		if((rand_range(0, 350 - score/20)) < 1):
			createRed()
		if((rand_range(0, 400 - score/20)) < 1):
			createBlue()
		if((rand_range(0, 200 - score/15)) < 1):
			createGreen()
		if((rand_range(0, 750 - score/30)) < 1):
			createHeart()
	if(diff == "hard"):
		if((rand_range(0, 125 - score/10)) < 1):
			createWhite()
		if((rand_range(0, 300 - score/20)) < 1):
			createRed()
		if((rand_range(0, 325 - score/20)) < 1):
			createBlue()
		if((rand_range(0, 150 - score/15)) < 1):
			createGreen()
		if((rand_range(0, 1000 - score/30)) < 1):
			createHeart()
	if(diff == "insane"):
		if((rand_range(0, 100 - score/10)) < 1):
			createWhite()
		if((rand_range(0, 250 - score/20)) < 1):
			createRed()
		if((rand_range(0, 250 - score/20)) < 1):
			createBlue()
		if((rand_range(0, 100 - score/15)) < 1):
			createGreen()
		if((rand_range(0, 2000 - score/30)) < 1):
			createHeart()

func createWhite():
	if(Globals.entityCount <= Globals.entityCountMax):
		var enemyWhite = enemyWhiteScene.instance()
		rand.randomize()
		var x = rand.randf_range(40, screen_size.x - 40)
		var y = -60
		enemyWhite.position.y = y
		enemyWhite.position.x = x
		enemyWhite.z_index = 0
		add_child(enemyWhite)
		Globals.entityCount += 1
		lastWhite = 0
		
func createWhiteBoss():
	if(Globals.entityCount <= Globals.entityCountMax):
		var enemyWhiteBoss = enemyWhiteBossScene.instance()
		rand.randomize()
		var x = rand.randf_range(40, screen_size.x - 40)
		var y = -60
		enemyWhiteBoss.position.y = y
		enemyWhiteBoss.position.x = x
		enemyWhiteBoss.z_index = 0
		add_child(enemyWhiteBoss)
		Globals.entityCount += 1
		lastWhite = 0

func createRed():
	if(Globals.entityCount <= Globals.entityCountMax):
		var enemyRed = enemyRedScene.instance()
		rand.randomize()
		var x = rand.randf_range(40, screen_size.x - 40)
		var y = -60
		enemyRed.position.y = y
		enemyRed.position.x = x
		add_child(enemyRed)
		Globals.entityCount += 1
		lastBlueRed = 0

func createRedBoss():
	if(Globals.entityCount <= Globals.entityCountMax):
		var enemyRedBoss = enemyRedBossScene.instance()
		rand.randomize()
		var x = rand.randf_range(40, screen_size.x - 40)
		var y = -60
		enemyRedBoss.position.y = y
		enemyRedBoss.position.x = x
		add_child(enemyRedBoss)
		Globals.entityCount += 1
		lastBlueRed = 0

func createBlue():
	if(Globals.entityCount <= Globals.entityCountMax):
		var enemyBlue = enemyBlueScene.instance()
		rand.randomize()
		var x = rand.randf_range(40, screen_size.x - 40)
		var y = -60
		enemyBlue.position.y = y
		enemyBlue.position.x = x
		add_child(enemyBlue)
		Globals.entityCount += 1
		lastBlueRed = 0

func createGreen():
	if(Globals.entityCount <= Globals.entityCountMax):
		var enemyGreen = enemyGreenScene.instance()
		rand.randomize()
		var x = rand.randf_range(40, screen_size.x - 40)
		var y = -60
		enemyGreen.position.y = y
		enemyGreen.position.x = x
		add_child(enemyGreen)
		Globals.entityCount += 1
		lastGreen = 0

func createGreenBoss():
	if(Globals.entityCount <= Globals.entityCountMax):
		var enemyGreenBoss = enemyGreenBossScene.instance()
		rand.randomize()
		var x = rand.randf_range(40, screen_size.x - 40)
		var y = -60
		enemyGreenBoss.position.y = y
		enemyGreenBoss.position.x = x
		add_child(enemyGreenBoss)
		Globals.entityCount += 1
		lastGreen = 0

func createHeart():
	if(Globals.entityCount <= Globals.entityCountMax):
		var friendlyHeart = friendlyHeartScene.instance()
		rand.randomize()
		var x = rand.randf_range(40, screen_size.x - 40)
		var y = -60
		friendlyHeart.position.y = y
		friendlyHeart.position.x = x
		add_child(friendlyHeart)
		Globals.entityCount += 1
		lastHeart = 0

func createCoin():
	if(Globals.entityCount <= Globals.entityCountMax):
		var coin = coinScene.instance()
		rand.randomize()
		var x = rand.randf_range(40, screen_size.x - 40)
		var y = -60
		coin.position.y = y
		coin.position.x = x
		add_child(coin)
		Globals.entityCount += 1

func draw():
	get_node("CanvasLayer/scoreLabel").text = "Score: " + String(score)
	get_node("CanvasLayer/levelProgress").value = score
	get_node("CanvasLayer/levelLabel").text = "Level: " + String(Globals.level)
	get_node("CanvasLayer/coinLabel").text = "x" + String(Globals.coins + Globals.tempCoins)
	
	if(Globals.items_dict.Shields >= 1):
		get_node("CanvasLayer/shieldButton").visible = true
	else:
		get_node("CanvasLayer/shieldButton").visible = false
		
	if(Globals.items_dict.Potions >= 1):
		get_node("CanvasLayer/potionButton").visible = true
	else:
		get_node("CanvasLayer/potionButton").visible = false

	
#	get_node("CanvasLayer/entityCountLabel").text = "Entities: " + String(Globals.entityCount)

func levelComplete():
	pause = 1
	get_node("CanvasLayer/levelCompleteContainer").visible = true
	if(Globals.level == 24):
		get_node("CanvasLayer/levelCompleteContainer/levelCompleteText").text = "Level " + String(Globals.level) + " Complete!\n" + "You win!!!"
	else:
		if(int(Globals.level) % 6 == 0):
			Globals.checkpoint = Globals.level + 1
		if(int(Globals.level) % 6 == 0):
			get_node("CanvasLayer/checkpointReachedText").text = "Checkpoint Level " + String(Globals.level + 1) + " Reached!"
			get_node("CanvasLayer/checkpointReachedText").visible = true
		get_node("CanvasLayer/levelCompleteContainer/levelCompleteText").text = "Level " + String(Globals.level) + " Complete!\n" + "Continue to Level " + String(Globals.level + 1) + "?" 
		get_node("CanvasLayer/levelCompleteButton").visible = true
		Globals.level += 1
	get_node("CanvasLayer/levelCompleteContainer/levelCompleteText").visible = true
	get_node("CanvasLayer/levelCompleteBG").visible = true
	get_node("CanvasLayer/menuButton").visible = true
	Globals.coins += Globals.tempCoins
	Globals.tempCoins = 0
	get_node("CanvasLayer/coinLabel").text = "x" + String(Globals.coins)
	save_game()

func defeat():
	pause = 1
	Globals.deathCount += 1
	get_node("CanvasLayer/levelCompleteContainer").visible = true
	get_node("CanvasLayer/levelCompleteContainer/levelCompleteText").text = "Level " + String(Globals.level) + " Failed!\n" + "Continue from last checkpoint? [Level " + String(Globals.checkpoint) + "]" 
	get_node("CanvasLayer/levelCompleteBG").visible = true
	get_node("CanvasLayer/levelCompleteContainer/levelCompleteText").visible = true
	get_node("CanvasLayer/levelFailedButton").visible = true
	get_node("CanvasLayer/menuButton").visible = true
	Globals.tempCoins = 0
	get_node("CanvasLayer/coinLabel").text = "x" + String(Globals.coins)
	Globals.level = Globals.checkpoint
	save_game()

func nextLevel():
	score = 0
#	if(Globals.health == 100):
#		Globals.perfectComplete += 1
#	if(Globals.perfectComplete == 2):
#		Globals.hasShield += 1
#		Globals.perfectComplete = 0
	Globals.health = 100
	Globals.entityCount = 0
	get_node("CanvasLayer/player_health").get_stylebox("fg").set_bg_color(Color((100.0 - Globals.health)/100, (Globals.health/100.0), 0))
	get_tree().reload_current_scene()

func loadCheckpoint():
	Globals.level = Globals.checkpoint
	score = 0
	Globals.health = 100
	Globals.entityCount = 0
	get_node("CanvasLayer/player_health").get_stylebox("fg").set_bg_color(Color((100.0 - Globals.health)/100, (Globals.health/100.0), 0))
	get_tree().reload_current_scene()

func _on_levelCompleteButton_pressed():
	nextLevel()

func _on_levelFailedButton_pressed():
	loadCheckpoint()
#	save_game()

func save():
	var save_dict = {
		"checkpoint" : Globals.checkpoint
	}
	return save_dict

func save_game():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	var lvl = { 'checkpoint': Globals.checkpoint }
	save_game.store_line(to_json({"checkpoint" : Globals.checkpoint}))
	save_game.store_line(to_json({"coins" : Globals.coins}))
	save_game.store_line(to_json({"deathCount" : Globals.deathCount}))
	save_game.store_line(to_json(Globals.items_dict))
	save_game.close()


func _on_menuButton_pressed():
	get_tree().change_scene("res://scenes/mainMenu.tscn")


func _on_potionButton_pressed():
	if(Globals.items_dict.Potions >= 1):
		Globals.health = 100
		# update health value
		get_node("CanvasLayer/player_health").set_value(Globals.health)
		# update color
		get_node("CanvasLayer/player_health").get_stylebox("fg").set_bg_color(Color((100.0 - Globals.health)/100, (Globals.health/100.0), 0)) 
		Globals.items_dict.Potions -= 1


func _on_shieldButton_pressed():
	if(Globals.items_dict.Shields >= 1):
		activateShield()
		Globals.items_dict.Shields -= 1

#func createShield():
#	var shield = shieldScene.instance()
#	var x = Globals.avatarX
#	var y = Globals.avatarY
#	shield.position.y = y
#	shield.position.x = x
#	#shield.z_index = 5
#	add_child(shield)
func activateShield():
	Globals.shieldActive = 1
	Globals.shieldLife = 500
	get_node("shieldAvatar").visible = true
	get_node("shieldAvatar/CollisionPolygon2D").disabled = false


func _on_menuButton2_pressed():
	get_tree().change_scene("res://scenes/mainMenu.tscn")
