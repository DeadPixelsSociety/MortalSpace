
extends Control

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	self.get_node("/root/game_variable").set_first_screen_size(OS.get_video_mode_size(0))
	print(get_node("/root/game_variable").get_first_screen_size())
	# Initialization here
	pass


