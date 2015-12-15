
extends "res://scripts/action_area2D.gd"

# member variables here, example:
# var a=2
# var b="textvar"

func _on_entering_area(body):
	._on_entering_area(body)
	get_node("information_board").popup()

func _on_leaving_area(body):
	._on_leaving_area(body) #the dot here call the parent method. 
	get_node("information_board").hide()

func action():
	if(false == is_activated()):
		_activate()
		print("teleporting to dungeon")
		get_node("/root/game/dungeon").go_to_dungeon(0, "")
		#TODO adding system to recognize dungeon type and if it need to be loaded for a particular one
	pass
	#TODO change dungeon from vessel to new dungeon



