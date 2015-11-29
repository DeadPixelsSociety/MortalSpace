
extends Node

# member variables here, example:
# var a=2
# var b="textvar"

var _ammo_left = 0
var _ammo_in_weapon = 0

#TODO Dissociate ammo in weapon and ammo left
func start_new_dungeon():
	_ammo_in_weapon = get_node("/root/player_variable").get_ammo()
	get_node("/root/game/HUD_canevas/HUD").refresh_ammo()
	pass

func get_ammo_in_weapon():
	return _ammo_in_weapon

func get_ammo_left():
	return _ammo_left

func use_ammo_in_weapon(ammo_used):
	_ammo_in_weapon -= ammo_used
	get_node("/root/game/HUD_canevas/HUD").refresh_ammo()

func _ready():
	# Initialization here
	pass


