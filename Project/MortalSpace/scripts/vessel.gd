
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"



func _ready():
	print("vessel is ready")
	var position = get_node("board_area").get_global_pos()
	print("position = ", position)
	position.x -= 250 #TODO valeur arbitraire, à remettre au propre. 
	get_node("/root/game/player").set_pos(position)
	pass


