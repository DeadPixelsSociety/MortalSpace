
extends Area2D

# member variables here, example:
# var a=2
# var b="textvar"

var _is_activated = false

func is_activated():
	return _is_activated

func _activate():
	_is_activated= true

func desactivate():
	_is_activated = false

func _change_current_action_trigger():
	get_node("/root/game/dungeon").set_node_which_active_trigger(self.get_path())

func _reset_trigger():
	get_node("/root/game/dungeon").set_node_which_active_trigger("")

func action():
	#Do nothing here, this sould be a virtual fonction, but I don't know how to write a virutal function with gdscript
	pass

func _ready():
	# Initialization here
	pass


