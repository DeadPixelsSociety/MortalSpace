
extends Node

const PASS="tghSDJK128#TyJy:;§"
const SAVE_DIRECTORY="user://"
const SAVE_EXTENSION=".chrctr"

var _save_path = ""

func get_save_path():
	return _save_path

func set_save_path(path):
		_save_path = path

func _name_to_path(name):
	return SAVE_DIRECTORY + name + SAVE_EXTENSION

func create_path_with_game_name(name):
	set_save_path(_name_to_path(name))

func save_data(first_time=false):
	var data_to_save = null#get_node("/root/game_variable").serialize()
	var global_game_variables = get_node("/root/register_node").get_persistent_data()
	var save_file = File.new()
	var save_path = get_node("/root/savedata_manager").get_save_path()
	
	print(save_path)
	
	if(false == first_time):
		if(!save_file.file_exists(save_path)):
			print("Sauvegarde inexistant, impossible de sauvegarder")
			return false
	else: 
		if(save_file.file_exists(save_path)):
			print("Impossible de creer la partie, il existe déjà un fichier portant ce nom.")
			return false
	
	save_file.open_encrypted_with_pass(save_path, File.WRITE, PASS)
	for persistent_data in global_game_variables:
		data_to_save = persistent_data.serialize()
		print("data_to_json = ", data_to_save.to_json())
		save_file.store_line(data_to_save.to_json())
		
	save_file.close()
	
	return true

func load_data_with_game_name(name):
	load_data(_name_to_path(name))

func load_data(path):
	var data_file = File.new()
	var data_to_restore = {}
	
	if(data_file.file_exists(path)):
		data_file.open_encrypted_with_pass(path, File.READ, PASS)
		
		get_node("/root/savedata_manager").set_save_path(path)
		
		while(!data_file.eof_reached()):
			data_to_restore.parse_json(data_file.get_line())
			print("data to restore = ", data_to_restore)
			get_node(data_to_restore["node_path"]).deserialize(data_to_restore)
		
		data_file.close()
	
	else:
		print("Impossible d'ouvrir la sauvegarde, le fichier semble inexsitant.")

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Initialization here
	pass


