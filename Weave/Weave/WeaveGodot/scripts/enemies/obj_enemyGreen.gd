extends Area2D

#Variables
var speed = 0
var greenTrailTime = 0
var greenTrailFrame = 1
var vineSpr = "vineSpr" + String(greenTrailFrame)
var rand = RandomNumberGenerator.new()
var trailGreenScene = load("res://scenes/enemies/trailGreen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.move == 1:
			speed = 5
			greenTrailTime += 1
			if(greenTrailTime == 6):
				createTrail()
				greenTrailTime = 0;
				greenTrailFrame +=1
				if(greenTrailFrame == 5):
					greenTrailFrame = 1
	else:
		speed = 0
	position.y += speed
	if is_instance_valid(self):
		if position.y > 700:
			Globals.entityCount -= 1
			queue_free()

func _on_obj_enemyGreen_body_entered(body):
	if (body.get_name() == "obj_avatar"):
		#print("Ouch!")
		if body.has_method("hit"):
			body.hit("green")
		Globals.entityCount -= 1
		queue_free()

func createTrail():
	var trailGreen = trailGreenScene.instance()
	#rand.randomize()
	trailGreen.position.y = self.position.y
	trailGreen.position.x = self.position.x
	trailGreen.scale.y = self.scale.y
	trailGreen.scale.x = self.scale.x
	if(greenTrailFrame == 1):
		trailGreen.get_node("obj_trailGreen").get_node("vineSpr1").visible = true
		trailGreen.get_node("obj_trailGreen").get_node("vineSpr2").visible = false
		trailGreen.get_node("obj_trailGreen").get_node("vineSpr3").visible = false
		trailGreen.get_node("obj_trailGreen").get_node("vineSpr4").visible = false
	if(greenTrailFrame == 2):
		trailGreen.get_node("obj_trailGreen").get_node("vineSpr1").visible = false
		trailGreen.get_node("obj_trailGreen").get_node("vineSpr2").visible = true
		trailGreen.get_node("obj_trailGreen").get_node("vineSpr3").visible = false
		trailGreen.get_node("obj_trailGreen").get_node("vineSpr4").visible = false
	if(greenTrailFrame == 3):
		trailGreen.get_node("obj_trailGreen").get_node("vineSpr1").visible = false
		trailGreen.get_node("obj_trailGreen").get_node("vineSpr2").visible = false
		trailGreen.get_node("obj_trailGreen").get_node("vineSpr3").visible = true
		trailGreen.get_node("obj_trailGreen").get_node("vineSpr4").visible = false
	if(greenTrailFrame == 4):
		trailGreen.get_node("obj_trailGreen").get_node("vineSpr1").visible = false
		trailGreen.get_node("obj_trailGreen").get_node("vineSpr2").visible = false
		trailGreen.get_node("obj_trailGreen").get_node("vineSpr3").visible = false
		trailGreen.get_node("obj_trailGreen").get_node("vineSpr4").visible = true
	self.get_parent().add_child(trailGreen)


func _on_obj_enemyGreen_area_entered(area):
	if (area.get_name() == "shieldAvatar"):
		Globals.entityCount -= 1
		queue_free()
