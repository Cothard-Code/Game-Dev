extends Area2D

#Variables
var speed = 0
var redTrailTime = 0
var rand = RandomNumberGenerator.new()
var trailRedScene = load("res://scenes/enemies/trailRed.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.move == 1:
			speed = 5
			redTrailTime += 1
			if(redTrailTime == 5):
				if(Globals.trailCount < Globals.trailCountMax):
					createTrail()
					Globals.trailCount += 1
				redTrailTime = 0;
	else:
		speed = 0
	position.y += speed
	#position.y += speed*delta
	if is_instance_valid(self):
		if position.y > 700:
			Globals.entityCount -= 1
			queue_free()


func _on_obj_enemyRed_body_entered(body):
	if (body.get_name() == "obj_avatar"):
		#print("Ouch!")
		if body.has_method("hit"):
			body.hit("red")
		Globals.entityCount -= 1
		queue_free()


func createTrail():
	var trailRed = trailRedScene.instance()
	#rand.randomize()
	trailRed.position.y = self.position.y + rand_range(-7, 7)
	trailRed.position.x = self.position.x + rand_range(-7, 7)
	self.get_parent().add_child(trailRed)


func _on_obj_enemyRed_area_entered(area):
	if (area.get_name() == "shieldAvatar"):
		Globals.entityCount -= 1
		queue_free()
