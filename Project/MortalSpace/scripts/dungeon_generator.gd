
extends Node

var room_scene = preload("res://scenes/room.scn")
var room_script = preload("res://scripts/room.gd")
var dungeon_collision_matrice = preload("res://scripts/dungeon_collision_matrice.gd")
var room_graph = preload("res://scripts/room_graph.gd")

var _collision_matrice = null
var _room_graph = null

const EPSILON = 0.00001 #Arbitrary number

const POS_INDEX = 0
const SIZE_INDEX = 1
const ROOM_INFO_NUMBER = 2

const MINIMAL_ROOM_SIZE = 5 #in tile, 3 floors, 2 walls

var   _2_PI      = 2*PI
var   _SQRT_2_PI = sqrt(2 * PI)

var _ORIGIN = Vector2(0,0)

var _expectation = 0.3
var _standard_deviation = 0.01

#Using to generate normal random number
var _gaussian_z0 = 0.0
var _gaussian_z1 = 0.0
var _generate_gaussian = true #True if we have to generate it, false otherwise

var _variance = _standard_deviation * _standard_deviation

var _room_list = Array()

var _room_scene_list = null

# member variables here, example:
# var a=2
# var b="textvar"

#random number following normal distribution using Box-Muller transform
#Algorithm find at : 
#https://en.wikipedia.org/wiki/Box-Muller_transform
func _generate_gaussian_noise(mu, sigma):
	var random_number_to_return

	if(true == _generate_gaussian):
		var u1 = 0.0
		var u2 = 0.0
		var sqrt_2_log_u1 = 0.0
		var u2_time_2PI = 0.0
		
		while(u1 < EPSILON):
			u1 = randf()
			u2 = randf()
		
		sqrt_2_log_u1 = sqrt(-2.0 * log(u1))
		u2_time_2PI   = _2_PI * u2
		
		_gaussian_z0 = sqrt_2_log_u1 * cos(u2_time_2PI)
		_gaussian_z1 = sqrt_2_log_u1 * sin(u2_time_2PI)
		
		random_number_to_return = _gaussian_z0 * sigma + mu
	
	else:
		random_number_to_return = _gaussian_z1 * sigma + mu
	
	_generate_gaussian != _generate_gaussian
	return random_number_to_return

func _generate_room_size(standard_derivation, minimal_room_size = MINIMAL_ROOM_SIZE):
	var room_size = _roundm(_generate_gaussian_noise(minimal_room_size, standard_derivation), 1)
	if(room_size < minimal_room_size):
		room_size = 2 * minimal_room_size - room_size
	
	return room_size

# algorithm find at : 
#http://www.gamasutra.com/blogs/AAdonaac/20150903/252889/Procedural_Dungeon_Generation_Algorithm.php
func _roundm(n, m):
		return floor((n + m -1)/m) * m

# algorithm find at : 
#http://www.gamasutra.com/blogs/AAdonaac/20150903/252889/Procedural_Dungeon_Generation_Algorithm.php
func _get_random_point_in_ring(ring_radius, hole_radius):
	var t = 2 * PI * randf()
	var u = randf() + randf()
	var r = null
	
	if(u > 1):
		r = 2-u
	else:
		r = u
	
	return Vector2( _roundm((ring_radius * r ) * cos(t), room_script.TILE_SIZE), _roundm((ring_radius * r + hole_radius)* sin(t), room_script.TILE_SIZE) )



func _generate_room_size_vec(room_size_x_derivation = 10, room_size_y_derivation = 10): 

	return Vector2(_generate_room_size(room_size_x_derivation), _generate_room_size(room_size_y_derivation))

func _generate_room(room_pos, room_size):

	var room = room_scene.instance()
	self.add_child(room)

	room.set_vector_size(room_size)
	room.set_global_pos(room_pos)
	room.set_tileset("res://tileset/tile_set_vaisseau_test.res")
	room.set_floor_tile(0)

	room.generate_room()

func _generate_dungeon_skeleton(room_number_created, room_number_kept, radius = 64000):
	var tmp_room_info_array = null
	
	for i in range (room_number_created):
		tmp_room_info_array = Array()
		tmp_room_info_array.resize(ROOM_INFO_NUMBER)
		tmp_room_info_array[POS_INDEX] = _get_random_point_in_ring(radius, room_number_created*40*room_script.TILE_SIZE)
		tmp_room_info_array[SIZE_INDEX] = _generate_room_size_vec()
		_room_list.push_back(tmp_room_info_array)
		
	#_room_pos_list.sort()
	#TODO sort pos_list
	#for i in range(room_number_created):
	#	_generate_room(radius)
	#
	#var room_list_size = _room_list.size()
	#for i in range(room_list_size):
	#	_room_list[i].generate_room()


#################################SPLITING#####################################

func _global_position_to_tile_position(pos):
	return pos/room_script.TILE_SIZE

func _get_distance_from_origin(room_array):
	return room_array[POS_INDEX].distance_to(_ORIGIN)

func _sort_room_by_distance_from_origin(array_to_sort): #Quick sort iteratif
	var stack = Array()
	var array_more = null
	var array_median = null
	var array_less = null
	var tmp_array_to_sort = array_to_sort
	
	var array_result = Array()
	
	var array_result_size = array_to_sort.size()
	
	array_result.resize(array_result_size)
	
	var filling_index = 0
	
	var size_tmp_array_to_sort = tmp_array_to_sort.size()
	
	var median = _get_distance_from_origin(tmp_array_to_sort[0])
	
	var last_place_in_stack = stack.size() - 1
	
	while(filling_index < array_result_size):
		
		size_tmp_array_to_sort = tmp_array_to_sort.size()
		#print("size of array to sort : ")
		#print(size_tmp_array_to_sort)
		
		if(size_tmp_array_to_sort == 1):
			array_result[filling_index] = tmp_array_to_sort[0]
			filling_index += 1
		else:
			array_more = Array()
			array_median = Array()
			array_less = Array()
			
			#print("array to sort : ")
			#print(tmp_array_to_sort)
			
			median = _get_distance_from_origin(tmp_array_to_sort[0])
			
			#print("Here we go")
			
			array_median.push_back(tmp_array_to_sort[0])
			
			for i in range(1, size_tmp_array_to_sort):
				if(_get_distance_from_origin(tmp_array_to_sort[i]) < median):
					array_less.push_back(tmp_array_to_sort[i])
				else:
					array_more.push_back(tmp_array_to_sort[i])
				
			if(array_more.empty() == false):
				stack.push_back(array_more)
			
			stack.push_back(array_median)
			
			if(array_less.empty() == false):
				stack.push_back(array_less)
		
		last_place_in_stack = stack.size() - 1
		if(0 <= last_place_in_stack):
			tmp_array_to_sort = stack[last_place_in_stack]
			stack.remove(last_place_in_stack)
		
		#print("Here is our stack : ")
		#print(stack)
		#Maybe we need to add a protection in case stack is empty, normaly it is impossible.
	
	return array_result

func _print_distance_in_array(sorted_array):
	for i in range (sorted_array.size()):
		print(_get_distance_from_origin(sorted_array[i]))

func _rooms_accretion():
	var room_list_size = _room_list.size()
	var target_position = null

	_collision_matrice = dungeon_collision_matrice.new()

	for i in range(room_list_size):
		target_position = Vector2(0,0)
		_move_room_to_dungeon(_room_scene_list[i], target_position)

func _move_room_to_dungeon(room, target_position):
	var x_direction = randf()
	var y_direction = randf()
	var gap = -1
	var x_or_y = true #true if we move in x coordinate, false otherwise
	var direction = 1

	if(x_direction > 0.5):
		x_direction = -1
	else:
		x_direction = 1
	
	if(y_direction > 0.5):
		y_direction = -1
	else:
		y_direction = 1

	#print("room position before collision_matrice = ", room.get_pos())

	while(0 != gap):
		
		x_or_y = randf() > 0.5
		if(true == x_or_y):
			direction = x_direction
		else: 
			direction = y_direction

		gap = _collision_matrice.get_new_gap(room, target_position, direction, x_or_y)
		
		#print("gap = ", gap)
		
		if(true == x_or_y):
			target_position.x += gap
		else:
			target_position.y += gap

	#print("target_position = ", target_position)

	room.set_pos(target_position)
	_collision_matrice.add_room_in_matrice(room)
		
	#print("room position = ", room.get_pos())
	
	


func _clean_kinematic():
	var colliding_array = Array()
	var is_colliding = true
	var room_scene_list_size = _room_scene_list.size()
	var i = 0
	while(true == is_colliding):
		is_colliding = false
		i = 0
		"""while(i < room_scene_list_size): 
			colliding_array = _room_scene_list[i]. get_colliding_bodies()
			print(colliding_array)
			i = i + 1"""
	
	for j in range(room_scene_list_size):
		_room_scene_list[j].remove_collision_shape()

func _draw_room_with_floor():
	var room_list_size = _room_list.size()
	#print(_room_list)
	for i in range(room_list_size):
		#print(_room_list[i][POS_INDEX])
		_generate_room(_room_list[i][POS_INDEX], _room_list[i][SIZE_INDEX])
	
	_room_scene_list = get_children()

func _add_wall_to_rooms():
	var room_scene_list_size = _room_scene_list.size()
	for i in range(room_scene_list_size):
		_room_scene_list[i].add_wall()

func get_starting_point():
	return _room_scene_list[0].get_pos()

func _create_neighborhood():
	var _room_scene_list_size = _room_scene_list.size()
	
	for i in range(0, _room_scene_list_size):
		_collision_matrice.get_neighbors(_room_scene_list[i])

func _add_doors_to_rooms():
	var room_list_size = _room_list.size()
	var room_neighborhood_liste_size = 0
	
	for i in range(room_list_size):
		room_neighborhood_liste_size = _room_scene_list[i].get_neighborhood().size()
		#WARING, each time we add a connection, we decrise noeighborhood size.
		while(room_neighborhood_liste_size != 0):
			_room_scene_list[i].get_neighborhood().add_connection_with_door(_room_scene_list[i], _room_scene_list[i].get_neighbor_at_index(0))
			room_neighborhood_liste_size = _room_scene_list[i].get_neighborhood().size()
			
		

###############################################################################
func _ready():
	"""var room_size_x = 0.0
	var room_size_y = 0.0
	var average = 0.0  
	for i in range(100):
		room_size_x = _generate_room_size(10) #Arbitrary number
		room_size_y = _generate_room_size(10) #Arbitrary number
		print(room_size_x, " | ", room_size_y)
		average += room_size_x + room_size_y
	
	print("moyenne = ",average / 200)"""
	#_generate_dungeon(1000,3, 6400)
	
	#get_node("/root/game/player").queue_free()
	_generate_dungeon_skeleton(100, 100, 6400)
	#var sorted_array = _sort_room_by_distance_from_origin(_room_list)
	#_print_distance_in_array(sorted_array)
	_draw_room_with_floor()
	_rooms_accretion()
	#_clean_kinematic()
	_add_wall_to_rooms()
	_create_neighborhood()
	_add_doors_to_rooms()
	
	pass
