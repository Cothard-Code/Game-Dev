extends Area2D

#Variables
var lifetime = 80
var val = .9

# Called when the node enters the scene tree for the first time.
func _ready():
	#$vineSpr1.modulate = Color.from_hsv(0, 0, val)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	lifetime -= 1
	val -= .01
	$vineSpr1.modulate = Color.from_hsv(0, 0, val)
	$vineSpr2.modulate = Color.from_hsv(0, 0, val)
	$vineSpr3.modulate = Color.from_hsv(0, 0, val)
	$vineSpr4.modulate = Color.from_hsv(0, 0, val)
	#if(lifetime == 0):
	#	queue_free()
	if(val < .15):
		queue_free()

func _on_obj_trailGreen_body_entered(body):
	if (body.get_name() == "obj_avatar"):
		#print("Ouch!")
		if body.has_method("hit"):
			body.hit("greenTrail")



func _on_obj_trailGreen_body_exited(body):
	if (body.get_name() == "obj_avatar"):
		#print("Ouch!")
		if body.has_method("unhit"):
			body.unhit("greenTrail")
