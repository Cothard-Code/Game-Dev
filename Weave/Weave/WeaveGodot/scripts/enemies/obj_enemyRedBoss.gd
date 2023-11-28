extends Area2D

#Variables
var speed = 0
var redBossTrailTime = 0
var redBossTrailFrame = 0
var rand = RandomNumberGenerator.new()
var trailRedBossScene = load("res://scenes/enemies/trailRedBoss.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.move == 1:
			speed = 5
			redBossTrailTime += 1
			if(redBossTrailTime == 50):
				if(Globals.trailCount < Globals.trailCountMax):
					createTrail()
					Globals.trailCount += 1
				redBossTrailTime = 0;
	else:
		speed = 0
	position.y += speed
	#position.y += speed*delta
	if is_instance_valid(self):
		if position.y > 700:
			Globals.entityCount -= 1
			queue_free()

func createTrail():
	var trailRedBoss = trailRedBossScene.instance()
	#rand.randomize()
	trailRedBoss.position.y = self.position.y + rand_range(-7, 7)
	trailRedBoss.position.x = self.position.x + rand_range(-7, 7)
	self.get_parent().add_child(trailRedBoss)

func _on_obj_enemyRedBoss_body_entered(body):
	if (body.get_name() == "obj_avatar"):
		#print("Ouch!")
		if body.has_method("hit"):
			body.hit("redBoss")
		Globals.entityCount -= 1
		queue_free()
