extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#var nextLevelRes= load("res://scenes/difficultyScene.tscn")
#var nextLevel = nextLevelRes.instance() 
#root.add_child(nextLevel)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_playButton_pressed():
	#print("Play Pressed")
	get_tree().change_scene("res://scenes/difficultySelect.tscn")
