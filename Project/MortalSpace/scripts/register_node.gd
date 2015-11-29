
extends Control

# member variables here, example:
# var a=2
# var b="textvar"

var _persistent_data = []

func add_persistent_data(node_to_add):
	_persistent_data.push_back(node_to_add)

func get_persistent_data():
	return _persistent_data

func _ready():
	hide()
	pass


