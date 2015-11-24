
extends VBoxContainer

const CHOICE   ="choice"

var difficulty_constant = preload("res://scripts/difficulty_constant.gd")

func _on_normal_choice_pressed():
	_on_choice_pressed(difficulty_constant.NORMAL)
	pass

func _on_difficult_choice_pressed():
	_on_choice_pressed(difficulty_constant.HARD)
	pass

func _on_hardcore_choice_pressed():
	_on_choice_pressed(difficulty_constant.HARDCORE)
	pass

func _on_choice_pressed(id_difficulty):
	var choice_list   = get_tree().get_nodes_in_group(CHOICE)
	var choice_number = choice_list.size()
	
	for i in range(choice_number):
		choice_list[i].set_pressed(false)
	
	choice_list[id_difficulty].set_pressed(true)
	get_node("/root/game_variable").choose_difficulty(id_difficulty)
	pass

func _ready():
	#Be carefull here, the order in adding process is important (This has to match with constant difficulty choice)
	get_node("normal_choice").add_to_group(CHOICE)
	get_node("difficult_choice").add_to_group(CHOICE)
	get_node("hardcore_choice").add_to_group(CHOICE)

	
	get_node("normal_choice").connect("pressed", self, "_on_normal_choice_pressed")
	get_node("difficult_choice").connect("pressed", self, "_on_difficult_choice_pressed")
	get_node("hardcore_choice").connect("pressed", self, "_on_hardcore_choice_pressed")
	set_process_input(true)
	pass


