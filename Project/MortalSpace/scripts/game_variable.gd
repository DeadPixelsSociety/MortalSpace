
extends Node


var difficulty_constant = preload("res://scripts/difficulty_constant.gd")

var _difficulty = difficulty_constant.NONE
var _is_difficulty_choosen = false

var _save_path = ""
var _is_path_changed = false

func valid_diffculty():
	_is_difficulty_choosen = true

func get_difficulty():
	return _difficulty

func choose_difficulty(choice):
	if(_is_difficulty_choosen == false):
		_difficulty = choice

func get_save_path():
	return _save_path

func set_save_path(path):
	if(false == _is_path_changed):
		_save_path = path
		_is_path_changed = true

func serialize():
	var save_data={
			"difficulty":_difficulty
		}
	return save_data

func deserialize(data):
	_difficulty = data["difficulty"]

