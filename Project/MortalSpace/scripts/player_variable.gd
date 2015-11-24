
extends Node

var _ammo = 100

func get_ammo():
	return _ammo

func use_ammo(used_ammo):
	_ammo -= used_ammo

func serialize():
	var save_data = {
			"ammo":_ammo
		}

func deserialize(data):
	_ammo = data["ammo"]

func _ready():
	# Initialization here
	pass


