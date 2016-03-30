
extends Node

# member variables here, example:
# var a=2
# var b="textvar"

var _room_list = Array()

func get_room_with_index(i):
	return _room_list[i]

func push_back(room):
	_room_list.push_back(room)

func size():
	return _room_list.size()

func _ready():
	# Initialization here
	pass


