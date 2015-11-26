
extends VBoxContainer

# member variables here, example:
# var a=2
# var b="textvar"

# member variables here, example:
# var a=2
# var b="textvar"

func  _input(ev):
	
	if ev.is_action("ui_cancel"):
		if(get_node("/root/game_variable").is_game_started()):
			if(ev.is_pressed()):
				if(get_node(".").is_hidden()):
					get_tree().set_pause(true)
					get_node(".").show()
				else:
					get_node(".").hide()
					get_tree().set_pause(false)
	pass

func switch_to_in_game_menu():
	get_node("load_button").hide()
	get_node("new_game_button").hide()
	get_node(".").hide()

func _on_new_game_button_pressed():

	get_tree().change_scene("res://scenes/new_game_menu.scn")
	print("Nouvelle partie")

func _on_load_button_pressed():
	get_tree().change_scene("res://scenes/load_menu.scn")
	print("Load")

func _on_option_button_pressed():
	print("Option")

func _on_quit_button_pressed():
	#if game is started, then we have to save the game state
	#TODO: Lorsque le vaisseau du joueur sera implémenté, il ne faudra sauvegarder l'état du jeu uniquement lorsqu'il sera sur son vaisseau.
	#		cad, une fois arrivé, et une fois au démarrage de donjon.
	#TODO: Faire un traitement spécial pour la difficulté hardcore.
	if(get_node("/root/game_variable").is_game_started()):
		get_node("/root/savedata_manager").save_data()
	
	print("Quitter")
	get_tree().quit()

func _ready():
	if(get_node("/root/game_variable").is_game_started()):
		switch_to_in_game_menu()
	get_node("new_game_button").connect("pressed", self, "_on_new_game_button_pressed")
	get_node("load_button").connect("pressed", self, "_on_load_button_pressed")
	get_node("option_button").connect("pressed", self, "_on_option_button_pressed")
	get_node("quit_button").connect("pressed", self, "_on_quit_button_pressed")
	get_node("introduction_sample").play("Benny-hill-theme")
	set_process_input(true)


