extends Area2D

#Variables
var speed = 0
var heartTrailTime = 0
var rand = RandomNumberGenerator.new()
var trailHeartScene = load("res://scenes/friendlies/trailHeart.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.move == 1:
			speed = 5
			heartTrailTime += 1
			if(heartTrailTime == 5):
				createTrail()
				heartTrailTime = 0;
	else:
		speed = 0
	position.y += speed
	if is_instance_valid(self):
		if position.y > 700:
			Globals.entityCount -= 1
			queue_free()

func _on_obj_friendlyHeart_body_entered(body):
	if (body.get_name() == "obj_avatar"):
		#print("Ouch!")
		if body.has_method("hit"):
			body.hit("heart")
		Globals.entityCount -= 1
		queue_free()

func createTrail():
	var trailHeart = trailHeartScene.instance()
	rand.randomize()
	trailHeart.position.y = self.position.y + rand_range(-7, 7)
	trailHeart.position.x = self.position.x + rand_range(-7, 7)
	self.get_parent().add_child(trailHeart)
