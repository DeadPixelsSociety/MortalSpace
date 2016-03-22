
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var _node_which_active_trigger = ""
var dungeon_generator = preload("res://scenes/dungeon_generator.scn")
var player_scene = preload("res://scenes/player.scn")

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
	self.get_node("../player").set_pos(Vector2(-100000,-100000))
	
	#get_tree().set_pause(true)
	#self.hide()
	if("" == dungeon_scene_path):
		#print(dungeon_generator.get_random_point_in_circle(128))
		dungeon = dungeon_generator
		
		#TODO: Replace this by the dungeon creation algorithm
		#dungeon_scene_path = "res://scenes/generated_dungeon.scn"
		#dungeon = load(dungeon_scene_path)
		
	else:
		dungeon = load(dungeon_scene_path)
	#Ici le double load pourrait être factorisé, mais c'est seulement un test, on ne chargera plus directement le donjon dans le premier test
	#puisqu'on devra le générer de toute pièce

	var dungeon_instance = dungeon.instance()
	add_child(dungeon_instance)
	self.get_node("../player").set_pos(dungeon_instance.get_starting_point())
	old_child.queue_free()
	
	
	#TODO: Adding a function to position the player
	#TODO: Adding a function to add enemies, using dungeon_type
	#self.show()
	#get_tree().set_pause(false)

#TODO: place player on starting point un dungeon
#TODO: load is current ammo and equipment
func _put_player_on_starting_point():
	var player = player_scene.instance()
	#player.set_pos(self.get_children()[0].get_starting_point())
	self.get_node("..").add_child(player)

func return_to_vessel():
	go_to_dungeon(0, "res://scenes/vessel.scn")

func _ready():
	# Initialization here
	pass


