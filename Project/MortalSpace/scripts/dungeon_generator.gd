
extends Node

var room_scene = preload("res://scenes/room.scn")

const TILE_SIZE = 64
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
func _get_random_point_in_circle(radius):
	var t = 2 * PI * randf()
	var u = randf() + randf()
	var r = null
	
	if(u > 1):
		r = 2-u
	else:
		r = u
	
	return Vector2( _roundm(radius * r * cos(t), TILE_SIZE), _roundm(radius * r * sin(t), TILE_SIZE) )



func _generate_room_size_vec(radius, room_size_x_derivation = 10, room_size_y_derivation = 10): 
#generate a room in a given radius
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
		tmp_room_info_array[POS_INDEX] = _get_random_point_in_circle(radius)
		tmp_room_info_array[SIZE_INDEX] = _generate_room_size_vec(radius)
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
	return pos/TILE_SIZE


func _superposition(room1, room2):
	var room1_origin = _global_position_to_tile_position(room1.get_global_pos())
	var room2_origin = _global_position_to_tile_position(room2.get_global_pos())
	
	var room1_end = room1_origin + room1.get_vector_size()
	var room2_end = room2_origin + room2.get_vector_size()
	
	return room1_origin.x < room2_end.x && room1_end.x > room2_origin.x && room1_origin.y < room2_end.y && room1_end.y > room2_origin.y

func _get_distance_from_origin(room_array):
	return room_array[POS_INDEX].distance_to(_ORIGIN)

func _sort_room_by_distance_from_origin(median): #Quick sort iteratif
	var stack = Array()
	var array_more = null
	var array_less = null
	var array_to_sort = _room_list
	
	var array_result = Array()
	
	while(array_result.size() < _room_list.size()):
		
		for i in range(array_to_sort.size()):
			pass 


func _draw_dungeon():
	var room_list_size = _room_list.size()
	#print(_room_list)
	for i in range(room_list_size):
		#print(_room_list[i][POS_INDEX])
		_generate_room(_room_list[i][POS_INDEX], _room_list[i][SIZE_INDEX])

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
	
	_generate_dungeon_skeleton(100, 100, 6400)
	_sort_room_by_distance_from_origin(3200)
	_draw_dungeon()
	pass


