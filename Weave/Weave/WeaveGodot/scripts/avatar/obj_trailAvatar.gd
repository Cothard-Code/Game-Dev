extends Area2D

#Variables
var lifetime = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	lifetime -= 1
	scale.x = .2 + (lifetime/25.0)
	scale.y = .2 + (lifetime/25.0)
	if(lifetime <= 0):
		queue_free()
