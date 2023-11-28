extends Area2D

#Variables
var speed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("play"):
			speed = 5
	else:
		speed = 0
	position.y += speed
	if is_instance_valid(self):
		if position.y > 700:
			Globals.entityCount -= 1
			queue_free()

func _on_obj_enemyWhite_body_entered(body):
	if (body.get_name() == "obj_avatar"):
		#print("Ouch!")
		if body.has_method("hit"):
			body.hit("white")
		Globals.entityCount -= 1
		queue_free()
	if (body.get_name() == "shieldAvatar"):
		Globals.entityCount -= 1
		queue_free()


func _on_obj_enemyWhite_area_entered(area):
	if (area.get_name() == "shieldAvatar"):
		Globals.entityCount -= 1
		queue_free()
