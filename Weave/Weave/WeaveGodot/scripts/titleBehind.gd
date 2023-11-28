extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Globals.titleGlow += .0025
	if(Globals.titleGlow > 1):
		Globals.titleGlow = 0
	modulate = Color.from_hsv(Globals.titleGlow, 1, 1)
