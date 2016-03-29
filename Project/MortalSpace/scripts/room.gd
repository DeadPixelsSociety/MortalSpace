
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

const TILE_SIZE = 64

var _size = Vector2(0.0, 0.0)
var _floor_tile = 0
var _wall_corner_tile = 1 #3 In reality it is 3 but I use one in this case to test the dungeon creation
var _wall_tile = 1 #2 In reality it is 2 but I use one in this case to test the dungeon creation


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
	print("tileset name = ", self.get_node("room_map").get_tileset().get_name())
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

#tile unit
func get_vector_size():
	return _size

func add_collision_shape():
	get_node("./shape").get_shape().set_extents(_size * TILE_SIZE)
	print("taille de la salle : ", _size)
	print("taille du la forme de collision : ", get_node("./shape").get_shape().get_extents()/64)

func remove_collision_shape():
	clear_shapes()

func _ready():
	pass


