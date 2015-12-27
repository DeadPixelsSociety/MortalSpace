
extends Node

var _ammo = 1000

func get_ammo():
	return _ammo

func serialize():
	var save_data = {
			node_path = get_path(),
			ammo=_ammo
	}
	return save_data

func deserialize(data):
	_ammo = data["ammo"]

func _ready():
	get_node("/root/register_node").add_persistent_data(self)
	

