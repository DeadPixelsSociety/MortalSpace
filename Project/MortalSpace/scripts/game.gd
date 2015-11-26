#Traitement des munitions et autres objets indépendants dans le jeu, un gros script donc.

extends Control


var ammo_scene = preload("res://scenes/ammo.scn")

func generate_bullet():
	add_child(ammo_scene.instance())

func _ready():
	get_node("/root/game_variable").start_game()
	print("ammo number = ", get_node("/root/player_variable").get_ammo())
	set_fixed_process(true)


