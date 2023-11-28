extends Area2D

#Variables
var speed = 0
var blueTrailTime = 0
var rand = RandomNumberGenerator.new()
var trailBlueScene = load("res://scenes/enemies/trailBlue.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.move == 1:
			speed = 5
			blueTrailTime += 1
			if(blueTrailTime == 4):
				createTrail()
				blueTrailTime = 0;
	else:
		speed = 0
	position.y += speed
	if is_instance_valid(self):
		if position.y > 700:
			Globals.entityCount -= 1
			queue_free()

#func _get_input():
#	if is_instance_valid(self):
		

func _on_obj_enemyBlue_body_entered(body):
	if (body.get_name() == "obj_avatar"):
		#print("Ouch!")
		if body.has_method("hit"):
			body.hit("blue")
		Globals.entityCount -= 1
		queue_free()

func createTrail():
	var trailBlue = trailBlueScene.instance()
	rand.randomize()
	trailBlue.position.y = self.position.y + rand_range(-7, 7)
	trailBlue.position.x = self.position.x + rand_range(-7, 7)
	self.get_parent().add_child(trailBlue)


func _on_obj_enemyBlue_area_entered(area):
	if (area.get_name() == "shieldAvatar"):
		Globals.entityCount -= 1
		queue_free()
