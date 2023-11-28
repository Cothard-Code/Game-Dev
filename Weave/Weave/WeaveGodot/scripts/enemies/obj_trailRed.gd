extends Area2D

#Variables
var lifetime = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	lifetime -= 1
	scale.x = (lifetime/30.0)
	scale.y = (lifetime/30.0)
	if(lifetime <= 0):
		Globals.trailCount -= 1
		queue_free()

func _on_obj_trailRed_area_entered(area):
	if (area.get_name() == "shieldAvatar"):
		Globals.entityCount -= 1
		queue_free()

func _on_obj_trailRed_body_entered(body):
	if (body.get_name() == "obj_avatar"):
		#print("Ouch!")
		if body.has_method("hit"):
			body.hit("redsTrail")
		Globals.trailCount -= 1
		queue_free()
