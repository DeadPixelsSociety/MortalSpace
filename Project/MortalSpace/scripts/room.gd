
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var _room_graph_node_class = preload("res://scripts/room_graph_node.gd")

const TILE_SIZE = 64
const DOOR_INTERVALLE = 3 * TILE_SIZE

var _size = Vector2(0.0, 0.0) #Tile unit
var _floor_tile = 0
var _wall_corner_tile = 1 #3 In reality it is 3 but I use one in this case to test the dungeon creation
var _wall_tile = 1 #2 In reality it is 2 but I use one in this case to test the dungeon creation

var _neighbors = _room_graph_node_class.new()

#Tile unit
func set_size(x, y):
	_size.x = x
	_size.y = y

#tile unit
func set_vector_size(vector_size):
	set_size(vector_size.x, vector_size.y)

func set_tileset(tileset_name):
	self.get_node("room_map").set_tileset(load(tileset_name))

func set_floor_tile(tile_number):
	_floor_tile = tile_number

func _create_room_floor():
	#print("tileset name = ", self.get_node("room_map").get_tileset().get_name())
	for x in range(_size.x):
		for y in range(_size.y):
			self.get_node("room_map").set_cell(x, y, _floor_tile)

#TODO : put wall with the good orientation
func _create_wall():
	self.get_node("room_map").set_cell(0, 0, _wall_corner_tile)
	self.get_node("room_map").set_cell(_size.x - 1, 0, _wall_corner_tile)
	self.get_node("room_map").set_cell(0, _size.y - 1, _wall_corner_tile)
	self.get_node("room_map").set_cell(_size.x -1, _size.y - 1, _wall_corner_tile)
	
	for x in [0, _size.x-1]:
		for y in range(1, _size.y -1):
			self.get_node("room_map").set_cell(x, y, _wall_tile)
			
	for y in [0, _size.y - 1]:
		for x in range(1, _size.x -1):
			self.get_node("room_map").set_cell(x, y, _wall_tile)

func add_wall():
	_create_wall()

func generate_room():
	_create_room_floor()

#pixel unit
func get_vector_size_in_px():
	return _size * TILE_SIZE

#tile unit
func get_vector_size():
	return _size

func add_collision_shape():
	get_node("./shape").get_shape().set_extents(_size * TILE_SIZE)
	print("taille de la salle : ", _size)
	print("taille du la forme de collision : ", get_node("./shape").get_shape().get_extents()/64)

func remove_collision_shape():
	clear_shapes()

func add_neighbor(room):
	_neighbors.add_neighbor(room)

func get_neighborhood():
	return _neighbors

func is_connected_with_at_least_n_space(room_1, room_2, n_space):
	var first_segment_point   = 0
	var second_segment_point = 0 

	if(   room_1.get_pos().x == room_2.get_pos().x + room_2.get_vector_size_in_px().x
	   or room_1.get_pos().x + room_1.get_vector_size_in_px().x == room_2.get_pos().x):
		first_segment_point  = max(room_1.get_pos().y, room_2.get_pos().y)
		second_segment_point = min(room_1.get_pos().y + room_1.get_vector_size_in_px().y, room_2.get_pos().y + room_2.get_vector_size_in_px().y)
	else:
		if(   room_1.get_pos().y == room_2.get_pos().y + room_2.get_vector_size_in_px().y 
		   or room_1.get_pos().y + room_1.get_vector_size_in_px().y == room_2.get_pos().y):
			first_segment_point  = max(room_1.get_pos().x, room_2.get_pos().x)
			second_segment_point = min(room_1.get_pos().x + room_1.get_vector_size_in_px().x, room_2.get_pos().x + room_2.get_vector_size_in_px().x)
	
	return second_segment_point - first_segment_point >= n_space * TILE_SIZE

func create_door(x1, x2, y1, y2):
	
	print("We put door in ", self)
	
	print("x1 = ", x1, "| x2 = ",x2, "| y1 = ",y1, "| y2 = ",y2)
	
	x1 = (x1 - self.get_pos().x)/TILE_SIZE
	x2 = (x2 - self.get_pos().x)/TILE_SIZE
	y1 = (y1 - self.get_pos().y)/TILE_SIZE
	y2 = (y2 - self.get_pos().y)/TILE_SIZE
	
	print("x1 = ", x1, "| x2 = ",x2, "| y1 = ",y1, "| y2 = ",y2)
	print("_size.x =  ",  _size.x)
	print("_size.y = ", _size.y)
	
	
	if(x1 == x2):
		y1 += 1
		y2 += 1
		if(x1 == _size.x):
			x1 = _size.x - 1 
			x2 = _size.x
		else:
			x2 = 1 
	else:
		x1 += 1
		x2 += 1
		if(y1 == _size.y):
			y1 = _size.y - 1 / 2
			y2 = _size.y
		else: 
			y2 = 1
	
	print("x1 = ", x1, "| x2 = ",x2, "| y1 = ",y1, "| y2 = ",y2)
	
	for i in range(x1, x2):
		for j in range(y1, y2):
			print(i, " | ", j)
			self.get_node("room_map").set_cell(x1+i, y1+j, _floor_tile)
	

func get_neighbor_at_index(index):
	return _neighbors.get_neighbor_at_index(index)

func _ready():
	pass


