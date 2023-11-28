extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("CanvasLayer/coinLabel").text = "x" + String(Globals.coins)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_potionBuy_pressed():
	if(Globals.coins >= 10):
		Globals.items_dict.Potions += 1
		Globals.coins -= 10
		get_node("CanvasLayer/coinLabel").text = "x" + String(Globals.coins)
		save_game()


func _on_shieldBuy_pressed():
	if(Globals.coins >= 10):
		Globals.items_dict.Shields += 1
		Globals.coins -= 10
		get_node("CanvasLayer/coinLabel").text = "x" + String(Globals.coins)
		save_game()

func save_game():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	var lvl = { 'checkpoint': Globals.checkpoint }
	save_game.store_line(to_json({"checkpoint" : Globals.checkpoint}))
	save_game.store_line(to_json({"coins" : Globals.coins}))
	save_game.store_line(to_json({"deathCount" : Globals.deathCount}))
	save_game.store_line(to_json(Globals.items_dict))
	save_game.close()
