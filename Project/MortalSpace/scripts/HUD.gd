
extends Control

# member variables here, example:
# var a=2
# var b="textvar"

#An other solution : place this function in _process(delta), but I think this solution cost a lot for nothing
func refresh_ammo():
	var ammo_in_weapon = get_node("/root/equipment_in_dungeon").get_ammo_in_weapon()
	var ammo_left      = get_node("/root/equipment_in_dungeon").get_ammo_left()
	var text_to_print  = str(ammo_in_weapon) + "/" + str(ammo_left)
	get_node("ammo_number").set_text(text_to_print)

func _ready():
	# Initialization here
	pass


