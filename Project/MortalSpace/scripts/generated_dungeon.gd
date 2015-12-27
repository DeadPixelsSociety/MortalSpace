tool
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
#const common = preload("res://scripts/CommonChildAccess.gd")


func _ready():

	# Initialization here
	#get_node("generated_dungeon_theme").play("ambiance")
	#var tileset = TileSet.new()
	#tileset.set_path("res://tileset/tile_set_vaisseau_test.res")
	#tileset.
	#for i in range(tileset.get_tiles_ids().size()):
	#	print("id",tileset.get_tiles_ids().find(0))
	
	#var tilemap = TileMap.new()
	#tilemap.set_tile_origin(0)
	#tilemap.set_tileset(tileset)
	#tilemap.set_tile_origin(0)
	#add_child(tilemap)
	var tilemap = get_child(0)
	print("tileset", tilemap.get_tileset())
	print("tileset path ", tilemap.get_tileset().get_path())
	
	print("tileset name ", tilemap.get_tileset().get_name())
	
	print("tileset type ", tilemap.get_tileset().get_type())
	
	var i = 0
	var j = 0
	for i in range(13):
		for j in range(13):
			tilemap.set_cell(i,j,0,false,false,false)
	tilemap.set_cell(3,3,1,false,false,false)
	
	var tileset = TileSet.new()
	tileset.set_path("res://tileset/tile_set_vaisseau_test.res")

	var tilemap1 = TileMap.new()
	tilemap1.set_tile_origin(0)
	tilemap1.set_tileset(tileset)
	tilemap1.set_tile_origin(0)
	add_child(tilemap1)
	
	var tilemap2 = get_child(1)
	print("tileset", tilemap.get_tileset())
	print("tileset path ", tilemap.get_tileset().get_path())
	
	print("tileset name ", tilemap.get_tileset().get_name())
	
	print("tileset type ", tilemap.get_tileset().get_type())
	set_process(true)

#func _process(delta):
	
	


