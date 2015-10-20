#Traitement des munitions et autres objets indépendants dans le jeu, un gros script donc.

extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var ammo_scene = preload("res://scenes/ammo.scn")

func generate_bullet():
	add_child(ammo_scene.instance())
	print(get_child(get_child_count()-1).get_child(1))
	print("On passe par là")

func _ready():
	set_fixed_process(true)


