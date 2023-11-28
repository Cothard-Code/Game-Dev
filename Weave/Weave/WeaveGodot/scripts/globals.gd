extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var items_dict = {"Potions": 0, "Shields": 0}
var difficulty = ""
var titleGlow = 0
var level = 1
var checkpoint = 1
var health = 100
var move = 0
var tempCoins = 0
var coins = 0
var entityCount = 0
var entityCountMax = 25
var trailCount = 0
var trailCountMax = 80
var hasShield = 1
var shieldTime = 0
var perfectComplete = 0
var deathCount = 0
var avatarX = 0
var avatarY = 0
var shieldActive = 0
var shieldLife = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
