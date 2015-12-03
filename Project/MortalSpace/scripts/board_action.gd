
extends "res://scripts/action_area2D.gd"

# member variables here, example:
# var a=2
# var b="textvar"

func _on_approaching_board(body):
	print("Enter")
	self._change_current_action_trigger()
	get_node("information_board").popup()

func _on_board_leaving(body):
	print("Out")
	self.desactivate()
	self._reset_trigger()
	get_node("information_board").hide()

func action():
	if(false == is_activated()):
		_activate()
		print("teleporting to dungeon")
		get_node("/root/game/dungeon").go_to_dungeon(0, "")
		#TODO adding system to recognize dungeon type and if it need to be loaded for a particular one
	pass
	#TODO change dungeon from vessel to new dungeon

func _ready():
	self.connect("body_enter", self, "_on_approaching_board")
	self.connect("body_exit", self, "_on_board_leaving")
	set_process_input(true)
	pass


