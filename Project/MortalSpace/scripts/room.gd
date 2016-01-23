
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var _size = Vector2(0.0, 0.0)
var _floor_tile = 0


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

func _create_floor_room():
	#print("tileset name = ", self.get_node("room_map").get_tileset().get_name())
	for x in range(_size.x):
		for y in range(_size.y):
			self.get_node("room_map").set_cell(x, y, _floor_tile)

func generate_room():
	_create_floor_room()

func get_vector_size():
	return _size

func _ready():
	pass


