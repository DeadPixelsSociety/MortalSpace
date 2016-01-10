
extends VBoxContainer

# member variables here, example:
# var a=2
# var b="textvar"

var _current_item = -1

func _on_item_selected(num_item):
	#recupérer identifiant de l'objet selectionné
	_current_item = num_item
	
	pass

func _on_validation_pressed():
	
	var savegame_name = get_node("savegame").get_item_text(_current_item)
	get_node("/root/savedata_manager").load_data_with_game_name(savegame_name)
	#TODO verification si chargement possible
	
	#start game 
	get_node("/root/game_variable").start_game()
	for i in get_tree().get_root().get_children():
		print(i.get_name())

	get_tree().change_scene("res://scenes/game.scn")

func _on_cancel_pressed():
	get_tree().change_scene("res://scenes/menu.scn")

func _fill_savegame():
	var savegame_directory = Directory.new()
	var savegame_name

	#dir_exists is broken on windows, so don't use that part until it's fixed
	#if(savegame_directory.dir_exists("user://")):
	#	savegame_directory.open("user://")
	#else:
	#	print("Impossible d'ouvrir le repertoire de sauvegarde")
	#	return
	savegame_directory.open("user://") #This have to be removed when dir_exists is fixed

	get_node("savegame").set_max_columns(1)	
	print("trying to open user://")

	
	#if(savegame_directory.list_dir_begin() == true): # Apparently this function return always flase on windows, has to fix it to.
	savegame_directory.list_dir_begin()
	savegame_name = savegame_directory.get_next()
	print("List of file found : ")
	while( "" != savegame_name):
		
		if(savegame_name.extension() == "chrctr"):
			get_node("savegame").add_item(savegame_name.basename())
		
		savegame_name = savegame_directory.get_next()


func _ready():
	_fill_savegame()
	get_node("valid_or_cancel_part").get_node("validation").connect("pressed", self, "_on_validation_pressed")
	get_node("valid_or_cancel_part").get_node("cancel").connect("pressed", self, "_on_cancel_pressed")
	get_node("savegame").connect("item_selected", self, "_on_item_selected")
	set_process_input(true)
	pass


