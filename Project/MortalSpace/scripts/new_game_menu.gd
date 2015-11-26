
extends VBoxContainer

# member variables here, example:
# var a=2
# var b="textvar"
var difficulty_constant = preload("res://scripts/difficulty_constant.gd")

var difficulty = difficulty_constant.NONE

func _on_start_pressed():
	
	var save_name = ""
	var difficulty = difficulty_constant.NONE
	
	#collect information
	difficulty = get_node("/root/game_variable").get_difficulty()
	save_name  = get_node("savegame_name_part").get_node("savegame_name").get_text()
	
	print(save_name)
	
	#verify information
	if(difficulty_constant.NONE == difficulty):
		print("Vous devez choisir une dificulté avant de démarrer")
	
	if( "" == save_name):
		print("Vous devez choisir un nom de fichier pour votre sauvegarde")
	else:
		print("Votre nom de fichier : ", save_name)
	
	if(difficulty_constant.NONE != difficulty and "" != save_name):
		#save information
		get_node("/root/savedata_manager").create_path_with_game_name(save_name)
		if(true == get_node("/root/savedata_manager").save_data(true)):
			
			#start game
			get_node("/root/game_variable").start_game()
			get_tree().change_scene("res://scenes/game.scn")
		else:
			print("Impossible de sauvegarder la partie, le nom de partie doit probablement déjà exister")
	
	pass

func _on_cancel_pressed():
	#load menu scene
	get_tree().change_scene("res://scenes/menu.scn")
	pass

func _ready():
	get_node("start").connect("pressed", self, "_on_start_pressed")
	get_node("cancel").connect("pressed", self, "_on_cancel_pressed")
	
	pass


