
extends Control

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	self.get_node("/root/game_variable").set_first_srceen_size(self.get_viewport().get_rect().size)
	# Initialization here
	pass


