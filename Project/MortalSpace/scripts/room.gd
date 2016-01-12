
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var _size = Vector2(0.0, 0.0)
var _tile_floor = 0

func set_size(x, y):
	_size.x = x
	_size.y = y

func set_vector_size(vector_size):
	set_size(vector_size.x, vector_size.y)

func set_tileset(tileset_name):
	self.get_node("room_map").set_tileset(load(tileset_name))

func set_tile_floor(tile_number):
	_tile_floor = tile_number

func _create_floor_room():
	print("tileset name = ", self.get_node("room_map").get_tileset().get_name())
	for x in range(_size.x):
		for y in range(_size.y):
			self.get_node("room_map").set_cell(x, y, _tile_floor)

func generate_room():
	_create_floor_room()

func _ready():
	pass


