
extends Node

static func save_data(first_time):
	var data_to_save = get_node("/root/game_variable").serialize()
	
	save_file = File.new()
	save_path = get_node("root/game_variable").get_save_path()

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Initialization here
	pass


