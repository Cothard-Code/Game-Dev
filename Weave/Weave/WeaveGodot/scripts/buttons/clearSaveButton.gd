extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_clearSaveButton_pressed():
	var dir = Directory.new()
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return # Error! We don't have a save to delete.
	dir.remove("user://savegame.save")
	Globals.checkpoint = 0
	Globals.level = 1
	#print(Globals.checkpoint)
	print("Save File Deleted")
	

