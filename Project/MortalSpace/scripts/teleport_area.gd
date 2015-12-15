
extends "res://scripts/action_area2D.gd"
# member variables here, example:
# var a=2
# var b="textvar"

func action():
	if(false == is_activated()):
		self.get_node("../teleport_anim").play("teleport")
		_activate()
		print("teleporting to vessel")
		get_node("/root/game/dungeon").go_to_dungeon(0, "res://scenes/vessel.scn")
		#TODO adding system to recognize dungeon type and if it need to be loaded for a particular one
	pass

func _ready():
	# Initialization here
	pass


