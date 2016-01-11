#Traitement des munitions et autres objets indépendants dans le jeu, un gros script donc.

extends Control


var ammo_scene = preload("res://scenes/ammo.scn")

func generate_bullet():
	add_child(ammo_scene.instance())

func _ready():
	randomize() #Create a new seed for all the random events in the game
	get_node("/root/game_variable").start_game()
	get_node("/root/equipment_in_dungeon").start_new_dungeon() #TODO: move this when vessels to dungeon function is implemented
	print("ammo number = ", get_node("/root/player_variable").get_ammo())
	set_fixed_process(true)


