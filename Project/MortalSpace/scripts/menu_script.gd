
extends VBoxContainer

# member variables here, example:
# var a=2
# var b="textvar"

# member variables here, example:
# var a=2
# var b="textvar"

var _is_started = false

func  _input(ev):
	
	if ev.is_action("ui_cancel"):
		if(true == _is_started): 
			if(ev.is_pressed()):
				if(get_node(".").is_hidden()):
					get_tree().set_pause(true)
					get_node(".").show()
				else:
					get_node(".").hide()
					get_tree().set_pause(false)
	pass

func game_is_starting():
	_is_started = true
	get_node("load_button").hide()
	get_node("new_game_button").hide()
	get_node(".").hide()

func _on_new_game_button_pressed():
	#Load the new game screen
	get_tree().change_scene("res://scenes/new_game_menu.scn")
	print("Nouvelle partie")

func _on_load_button_pressed():
	print("Load")

func _on_option_button_pressed():
	print("Option")

func _on_quit_button_pressed():
	print("Quitter")
	get_tree().quit()

func _ready():
	get_node("new_game_button").connect("pressed", self, "_on_new_game_button_pressed")
	get_node("load_button").connect("pressed", self, "_on_load_button_pressed")
	get_node("option_button").connect("pressed", self, "_on_option_button_pressed")
	get_node("quit_button").connect("pressed", self, "_on_quit_button_pressed")
	set_process_input(true)


