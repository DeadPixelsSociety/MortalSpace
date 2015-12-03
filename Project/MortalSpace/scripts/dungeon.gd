
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var _node_which_active_trigger = ""

func set_node_which_active_trigger(new_node_path):
	_node_which_active_trigger = new_node_path
	print("_node_which_active_trigger = ", _node_which_active_trigger)

func activate_trigger():
		if("" != _node_which_active_trigger):
			get_node(_node_which_active_trigger).action()

#TODO: Pour le moment, le changement de donjon s'effectue en cachant le noeud dungeon, c'est une solution provisoire
#Il serait bien de faire une annimation : soit un écran de chargement, soit une annimation ou le héro est téléporté.
func go_to_dungeon(dungeon_type, dungeon_scene_path = ""):
	var dungeon
	var old_child = (self.get_children())[0]

	get_tree().set_pause(true)
	self.hide()
	if("" == dungeon_scene_path):
		#TODO: Replace this by the dungeon creation algorithm
		dungeon_scene_path = "res://scenes/generated_dungeon.scn"
		dungeon = load(dungeon_scene_path)
	else:
		dungeon = load(dungeon_scene_path)
	#Ici le double load pourrait être factorisé, mais c'est seulement un test, on ne chargera plus directement le donjon dans le premier test
	#puisqu'on devra le générer de toute pièce

	add_child(dungeon.instance())
	old_child.queue_free() 
	#TODO: Adding a function to position the player
	#TODO: Adding a function to add enemies, using dungeon_type
	self.show()
	get_tree().set_pause(false)

func return_to_vessel():
	go_to_dungeon(0, "res://scenes/vessel.scn")

func _ready():
	# Initialization here
	pass


