extends Area2D


# Declare member variables here. Examples:
var lifetime = 5000


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	lifetime -= 1
	self.position.x = Globals.avatarX
	self.position.y = Globals.avatarY
	print("Shield location =  " + String(self.z_index))
	if(lifetime <= 0):
		queue_free()
