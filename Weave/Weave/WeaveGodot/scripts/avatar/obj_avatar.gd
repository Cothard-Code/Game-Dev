extends KinematicBody2D

#Variables
var velocity = Vector2(200, 0)
var velocityTemp = 0
var velocityTempVines = 0
#export var health = 100
var onFire = 0
var onIce = 0
var onVines = 0
var avatarTrailTime = 0
var trailAvatarScene = load("res://scenes/avatar/trailAvatar.tscn")
var shieldScene = load("res://scenes/avatar/shieldAvatar.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	avatarTrailTime += 1
#	if (Input.is_action_just_pressed("useShield")):
#		if(Globals.hasShield >= 1):
#			Globals.shieldTime += 400
#			Globals.hasShield -= 1
#			get_node("spr_av").modulate = Color(1, 0, 0)
#			#self.get_parent().get_node("CanvasLayer/shield_health").visible = true
	
#	if(Globals.shieldTime == 0):
#		get_node("spr_av").modulate = Color(1, 1, 1)
#		#self.get_parent().get_node("CanvasLayer/shield_health").visible = false
#	if(Globals.shieldTime > 0):
#		Globals.shieldTime -= 1
#	#	update_shieldbar()
	Globals.avatarX = self.position.x
	Globals.avatarY = self.position.y
	if(onIce == 0):
		avatarTrailTime += 1
		if(avatarTrailTime == 5):
				createTrail()
				avatarTrailTime = 0;
	
	if(onFire != 0):
		$onFire_particles.visible = true
		if(onFire % 10 == 0):
			Globals.health -= .5
			update_healthbar(Globals.health)
		onFire -= 1
		$onFire_particles.modulate = Color(1, 1, 1, (onFire/300.0))
	else:
		$onFire_particles.visible = false
	
	if(onIce != 0):
		$onIce_particles.visible = true
		velocity.x = 0
		onIce -= 1
		if(onIce == 0):
			velocity.x = velocityTemp # Reset velocity.x to Pre-Frozen value
		$onIce_particles.modulate = Color(1, 1, 1, (onIce/300.0))
	else:
		$onIce_particles.visible = false
	#pass


func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if (collision_info):
		if (collision_info.collider.name == "obj_wallLeft" || collision_info.collider.name == "obj_wallRight"):
			velocity.x = velocity.x * -1
			velocityTempVines = velocityTempVines * -1


func hit(type):
#	if(Globals.shieldTime == 0):
	if(type == "white"):
		Globals.health -= 10
	if(type == "red"):
		Globals.health -= 10
		onFire = 300
		if(onIce > 0):
			onIce = 0
			velocity.x = velocityTemp # Reset velocity.x to Pre-Frozen value
	if(type == "redTrail"):
		Globals.health -= 2
		if(onFire > 0 && onFire < 250):
			onFire += 10
	if(type == "redBoss"):
		Globals.health -= 20
		onFire = 300
		if(onIce > 0):
			onIce = 0
			velocity.x = velocityTemp # Reset velocity.x to Pre-Frozen value
	if(type == "redBossTrail"):
		Globals.health -= 8
		if(onFire > 0 && onFire < 250):
			onFire += 10
	if(type == "blue"):
		Globals.health -= 10
		if(onIce == 0):
			velocityTemp = velocity.x
		onIce = 250
		if(onFire > 0):
			onFire = 0
	if(type == "blueTrail"):
		Globals.health -= 2
		if(onFire > 10):
			onFire -= 10
	if(type == "green"):
		Globals.health -= 10
	if(type == "greenTrail"):
		if(onVines == 0):
			velocityTempVines = velocity.x
			velocity.x = velocity.x/3
			onVines = 1
	if(type == "heart"):
		Globals.health += 15
	if(type == "heartTrail"):
		Globals.health += 3
	if(type == "coin"):
		Globals.tempCoins += 1
#	if(Globals.health <= 0):
#		print("dead")
	if(Globals.health > 100):
		Globals.health = 100
	update_healthbar(Globals.health)
	#if(Globals.shieldTime > 0):
	#	update_shieldbar()

func unhit(type):
	if(type == "greenTrail"):
		velocity.x = velocityTempVines
		onVines = 0

func createTrail():
	var trailAvatar = trailAvatarScene.instance()
	trailAvatar.position.y = self.position.y
	trailAvatar.position.x = self.position.x
	if(velocity.x < 0):
		trailAvatar.rotation_degrees = 180
	self.get_parent().add_child(trailAvatar)
	
#func createShield():
#	var shield = shieldScene.instance()
#	shield.position.y = self.position.y
#	shield.position.x = self.position.x
#	#shield.z_index = 5
#	self.get_parent().add_child(shield)

func update_healthbar(new_health):
	# update health value
	self.get_parent().get_node("CanvasLayer/player_health").set_value(new_health)
	# update color
	self.get_parent().get_node("CanvasLayer/player_health").get_stylebox("fg").set_bg_color(Color((100.0 - Globals.health)/100, (Globals.health/100.0), 0)) 

#func update_shieldbar():
#	# update shield value
#	self.get_parent().get_node("CanvasLayer/shield_health").set_value(Globals.shieldTime)
#	# update color
#	self.get_parent().get_node("CanvasLayer/shield_health").get_stylebox("fg").set_bg_color(Color(0, (Globals.shieldTime/400), 0)) 


#func _on_shieldButton_pressed():
#	if(Globals.items_dict.Shields >= 1):
#		createShield()
#		Globals.items_dict.Shields -= 1
