extends Area2D

#Variables
var lifetime = 35

# Called when the node enters the scene tree for the first time.
func _ready():
	scale.x = ((lifetime-5)/35.0)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	lifetime -= 1
	scale.x = ((lifetime-5)/35.0)
	scale.y = ((lifetime-5)/35.0)
	if(lifetime <= 0):
		queue_free()

func _on_obj_trailHeart_body_entered(body):
	if (body.get_name() == "obj_avatar"):
		#print("Ouch!")
		if body.has_method("hit"):
			body.hit("heartTrail")
		queue_free()
