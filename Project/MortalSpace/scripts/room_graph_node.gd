
extends Node

# member variables here, example:
# var a=2
# var b="textvar"

var room_class = preload("res://scripts/room.gd")

var _child_left  = null
var _child_right = null

var neighbors_list = Array()
var neighbors_connection_list = Array()

func size():
	return neighbors_list.size()

func get_neighbor_at_index(index):
	return neighbors_list[index]

func add_neighbor(room):
	neighbors_list.push_back(room)

#WARNING each time we add connection we decrease both neighborhood list size for each room.
func add_connection_with_door(room_node, room_neighbor, first_access = true):
	var i = 0
	var neighbors_list_size = neighbors_list.size()
	while(i < neighbors_list_size and room_neighbor != neighbors_list[i]):
		i += 1
	
	if( i < neighbors_list_size):
		neighbors_list.remove(i)
		neighbors_connection_list.push_back(room_neighbor)
		if(true == first_access):
			_place_door(room_node, room_neighbor)
			add_connection_with_door(room_neighbor, room_node, false)

#TODO finir la fonction de mise en place des portes entre deux pieces
#TODO Center the door
func _place_door(room_1, room_2):
	var x_door_intervalle = 0
	var y_door_intervalle = 0
	
	var x_room_1 = 0
	var x_room_2 = 0
	var y_room_1 = 0
	var y_room_2 = 0
	
	
	if(room_1.get_pos().x == room_2.get_pos().x + room_2.get_vector_size_in_px().x):
		x_room_1 = room_1.get_pos().x
		x_room_2 = room_2.get_pos().x + room_2.get_vector_size_in_px().x
		y_room_1 = max(room_1.get_pos().y, room_2.get_pos().y)
		y_room_2 = y_room_1
		y_door_intervalle = room_class.DOOR_INTERVALLE

	if(room_1.get_pos().x + room_1.get_vector_size_in_px().x == room_2.get_pos().x):
		x_room_1 = room_1.get_pos().x + room_1.get_vector_size_in_px().x
		x_room_2 = room_2.get_pos().x
		y_room_1 = max(room_1.get_pos().y, room_2.get_pos().y)
		y_room_2 = y_room_1
		y_door_intervalle = room_class.DOOR_INTERVALLE

	if(room_1.get_pos().y == room_2.get_pos().y + room_2.get_vector_size_in_px().y):
		y_room_1 = room_1.get_pos().y
		y_room_2 = room_2.get_pos().y + room_2.get_vector_size_in_px().y
		x_room_1 = max(room_1.get_pos().x, room_2.get_pos().x)
		x_room_2 = x_room_1
		x_door_intervalle = room_class.DOOR_INTERVALLE

	if(room_1.get_pos().y + room_1.get_vector_size_in_px().y == room_2.get_pos().y):
		y_room_1 = room_1.get_pos().y + room_1.get_vector_size_in_px().y
		y_room_2 = room_2.get_pos().y
		x_room_1 = max(room_1.get_pos().x, room_2.get_pos().x) 
		x_room_2 = x_room_1
		x_door_intervalle = room_class.DOOR_INTERVALLE

	room_1.create_door(x_room_1, x_room_1 + x_door_intervalle, y_room_1, y_room_1 + y_door_intervalle)
	room_2.create_door(x_room_2, x_room_2 + x_door_intervalle, y_room_2, y_room_2 + y_door_intervalle)

func _ready():
	# Initialization here
	pass


