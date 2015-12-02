
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

func _on_approaching_board(body):
	print("Enter")
	get_node("board_area/information_board").popup()

func _on_board_leaving(body):
	print("Out")
	get_node("board_area/information_board").hide()



func _ready():
	get_node("board_area").connect("body_enter", self, "_on_approaching_board")
	get_node("board_area").connect("body_exit", self, "_on_board_leaving")
	set_process_input(true)
	pass


