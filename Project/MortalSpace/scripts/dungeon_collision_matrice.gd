
extends Node

# member variables here, example:
# var a=2
# var b="textvar"

var room_script = preload("res://scripts/room.gd")
var room_list = preload("res://scripts/room_list.gd")

const SQUARE_SIZE = 20
const MATRICE_SIZE = 200

var _matrice = Array()


func pos_number_to_matrice_index(pos_number):
	var negative_number = 0
	
	if(pos_number < 0):
		negative_number = -1
	
	return MATRICE_SIZE/2 + floor(pos_number / (SQUARE_SIZE*room_script.TILE_SIZE)) +negative_number

func _get_matrice_x_index(room, target):
	var room_position = room.get_pos()
	var room_size = room.get_vector_size()

	var start_range_x = pos_number_to_matrice_index(target.x)
	var end_range_x = min(pos_number_to_matrice_index(target.x + room_size.x * room_script.TILE_SIZE) + 1, MATRICE_SIZE) #+1 beacause it is used in for loop, or it is our stop case
	
	return Vector2(start_range_x, end_range_x)

func _get_matrice_y_index(room, target):
	var room_position = room.get_pos()
	var room_size = room.get_vector_size()

	var start_range_y = pos_number_to_matrice_index(target.y)
	var end_range_y = min(pos_number_to_matrice_index(target.y + room_size.y * room_script.TILE_SIZE) + 1, MATRICE_SIZE) #same as x

	return Vector2(start_range_y, end_range_y)

func get_collision_gap_room_to_room(room_to_move, target, room_already_placed, direction, x_or_y):
	var room_to_move_size = room_to_move.get_vector_size() * room_script.TILE_SIZE
	var room_placed_pos = room_already_placed.get_pos()
	var room_placed_size = room_already_placed.get_vector_size() * room_script.TILE_SIZE
	var gap = 0
	
	
	if(     target.x < room_placed_pos.x + room_placed_size.x
		and room_placed_pos.x < target.x + room_to_move_size.x
		and target.y < room_placed_pos.y + room_placed_size.y
		and room_placed_pos.y < target.y + room_to_move_size.y):
		
		if(true == x_or_y ):
			if(1 == direction):
				gap = room_placed_size.x - (target.x - room_placed_pos.x)
			else:
				gap = - room_to_move_size.x - (target.x - room_placed_pos.x) 
		else:
			if(1 == direction):
				gap = room_placed_size.y - (target.y - room_placed_pos.y)
			else:
				gap = - room_to_move_size.y - (target.y - room_placed_pos.y)
	
	return gap 

func get_collision_gap( i, j, room, target, direction, x_or_y):
	var gap = 0
	var k = 0
	var room_number_to_test = _matrice[i][j].size()
	var room_already_placed = null
	
	while(k < room_number_to_test and 0 == gap):
		room_already_placed = _matrice[i][j].get_room_with_index(k)
		gap = get_collision_gap_room_to_room(room, target, room_already_placed, direction, x_or_y)
		k += 1 
	
	return gap

func get_new_gap(room, target_position, direction, x_or_y):
	var x_index = _get_matrice_x_index(room, target_position)
	var y_index = _get_matrice_y_index(room, target_position)
	var gap = 0

	var i = x_index.x
	var j = y_index.x
	
	while(0 == gap and i < x_index.y):
		
		j=0
		while(0 == gap and j < y_index.y):
		
			gap = get_collision_gap(i, j, room, target_position, direction, x_or_y)
			j +=1
		
		i+=1
	
	return gap

func add_room_in_matrice(room):
	var x_index = _get_matrice_x_index(room, room.get_pos())
	var y_index = _get_matrice_y_index(room, room.get_pos())

	for i in range(x_index.x, x_index.y):
		for j in range(y_index.x, y_index.y):
			#print("Ajout dans la case ", i, ", ", j)
			_matrice[i][j].push_back(room)

	pass

func get_size_at(i, j):
	return _matrice[i][j].size()

func get_neighbors(room):
	var x_index = null
	var y_index = null
	var end_room = room.get_pos() + room.get_vector_size()
	var list_size = 0
	
	x_index = _get_matrice_x_index(room, end_room)
	y_index = _get_matrice_y_index(room, end_room)
	
	for i in range(x_index.x, x_index.y):
		for j in range(y_index.x, y_index.y):
			list_size = _matrice[i][j].size()
			for k in range(0, list_size):
				room.add_neighbor(_matrice[i][j].get_room_with_index(k))

func _init():
	
	var tab_temp = null
	_matrice.resize(MATRICE_SIZE)
	#print("taille matrice = ",  _matrice.size())  
	for i in range(MATRICE_SIZE):
		tab_temp = Array()
		tab_temp.resize(MATRICE_SIZE)
		_matrice[i] = tab_temp
		#print("taille matrice pour ", i , " = ", _matrice[i].size()) 
		for j in range(MATRICE_SIZE): 
			_matrice[i][j] = room_list.new()



