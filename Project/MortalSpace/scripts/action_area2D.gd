
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


func _on_entering_area(body):
	print("Enter")
	self._change_current_action_trigger()

func _on_leaving_area(body):
	print("Out")
	self.desactivate()
	self._reset_trigger()

func _ready():
	self.connect("body_enter", self, "_on_entering_area")
	self.connect("body_exit", self, "_on_leaving_area")
	set_process_input(true)


