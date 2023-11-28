extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Globals.shieldLife > 0):
		Globals.shieldLife -= 1
		self.position.x = Globals.avatarX
		self.position.y = Globals.avatarY
	else:
		Globals.shieldActive = 0
	
	if(Globals.shieldActive == 0):
		self.visible = false
		get_node("CollisionPolygon2D").disabled = true
		self.position.x = -100
