extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	load_game()
	print("Items: " + String(Globals.items_dict))
	get_node("CanvasLayer/coinsLabel").text = "x" + String(Globals.coins)
	#delete_savefile()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.

	# We need to revert the game state so we're not cloning objects
	# during loading. This will vary wildly depending on the needs of a
	# project, so take care with this step.
	# For our example, we will accomplish this by deleting saveable objects.

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	save_game.open("user://savegame.save", File.READ)
	#var text = save_game.get_as_text()
	var current_line = parse_json(save_game.get_line())
	Globals.checkpoint = current_line["checkpoint"]
	Globals.level = current_line["checkpoint"]
	
	current_line = parse_json(save_game.get_line())
	Globals.coins = current_line["coins"]
	
	current_line = parse_json(save_game.get_line())
	Globals.deathCount = current_line["deathCount"]
	
	current_line = parse_json(save_game.get_line())
	Globals.items_dict = current_line
	
	save_game.close()
	print("Current Checkpoint: " + String(Globals.checkpoint))
	print("Current Coins: " + String(Globals.coins))
	print("Current Death Count: " + String(Globals.deathCount))

func delete_savefile():
	var dir = Directory.new()
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return # Error! We don't have a save to delete.
	dir.remove("user://savegame.save")
	Globals.checkpoint = 0
	Globals.level = 1
	Globals.deathCount = 0
	#print(Globals.checkpoint)
	print("Save File Deleted")
