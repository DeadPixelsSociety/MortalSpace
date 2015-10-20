
extends VBoxContainer

# member variables here, example:
# var a=2
# var b="textvar"

# member variables here, example:
# var a=2
# var b="textvar"

func  _input(ev):
	if ev.is_action("ui_cancel"):
		if(ev.is_pressed()):
			if(get_node(".").is_hidden()):
				get_tree().set_pause(true)
				get_node(".").show()
			else:
				get_node(".").hide()
				get_tree().set_pause(false)

func _on_new_game_button_pressed():
	print("Nouvelle partie")

func _on_option_button_pressed():
	print("Option")

func _on_quit_button_pressed():
	print("Quitter")
	get_tree().quit()

func _ready():
	get_node("new_game_button").connect("pressed", self, "_on_new_game_button_pressed")
	get_node("option_button").connect("pressed", self, "_on_option_button_pressed")
	get_node("quit_button").connect("pressed", self, "_on_quit_button_pressed")
	set_process_input(true)


