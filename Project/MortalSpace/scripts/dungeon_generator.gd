
extends Node

var room_scene = preload("res://scenes/room.scn")

const TILE_SIZE = 64
const EPSILON = 0.00001 #Arbitrary number

const MINIMAL_ROOM_SIZE = 5 #in tile, 3 floors, 2 walls

var   _2_PI      = 2*PI
var   _SQRT_2_PI = sqrt(2 * PI)

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

func _generate_room(radius, room_size_x_derivation = 10, room_size_y_derivation = 10): #generate a room in a given radius
	var room_size = Vector2(_generate_room_size(room_size_x_derivation), _generate_room_size(room_size_y_derivation))
	var room = room_scene.instance()
	
	self.add_child(room)

	room.set_vector_size(room_size)
	room.set_global_pos(_get_random_point_in_circle(radius))
	room.set_tileset("res://tileset/tile_set_vaisseau_test.res")
	room.set_tile_floor(0)

	_room_list.push_back(room)

func _generate_dungeon(room_number_created, room_number_kept, radius = 64000):
	for i in range(room_number_created):
		_generate_room(radius)
	
	var room_list_size = _room_list.size()
	for i in range(room_list_size):
		print("room generation")
		_room_list[i].generate_room()


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
	_generate_dungeon(1000,3, 6400)
	pass

