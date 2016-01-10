
extends Node

var difficulty_constant = preload("res://scripts/difficulty_constant.gd")

var _screen_size = null

var _is_game_started = false

var _difficulty = difficulty_constant.NONE

func get_difficulty():
	return _difficulty

func choose_difficulty(choice):
	_difficulty = choice

func serialize():
	var save_data={
			node_path = get_path(),
			difficulty = _difficulty
		}
	return save_data

func deserialize(data):
	_difficulty = data["difficulty"]

func start_game():
	_is_game_started = true

func is_game_started():
	return _is_game_started

func get_first_screen_size():
	return _screen_size

func set_first_srceen_size(screen):
	if(null == _screen_size):
		_screen_size = screen

func _ready():
	get_node("/root/register_node").add_persistent_data(self)