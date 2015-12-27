
extends "res://scripts/character.gd"



const TIME_TO_MOVE = 2.0
const TIME_TO_SHOOT = 2.0

var enemy_speed = 200
var time = 0.0
var is_time_to_move = true
var trajectory = Vector2(0,0)
var enemy_pos = Vector2(0,0)
var enemy_life = 10

func _shoot(delta):
	get_node("enemy_weapon").fire(delta)

func _move(delta):

	if(randf() < 0.01):
		trajectory.x = (randf() - 0.5)*2
		trajectory.y = (randf() - 0.5)*2
	
	enemy_pos += trajectory*enemy_speed*delta
	get_node(".").move_to(enemy_pos)
	if(is_colliding()):
		trajectory.x = (randf() - 0.5)*2
		trajectory.y = (randf() - 0.5)*2
	

func _fixed_process(delta):

	var player_pos      = get_node("/root/game/player").get_global_pos()
	var delta_x         = enemy_pos.x - player_pos.x
	var delta_y         = enemy_pos.y - player_pos.y
	var angle           = atan2(delta_x, delta_y)
	
	get_node(".").set_rot(angle)
	
	if(enemy_life<=0):
		get_node(".").queue_free()

	if(true == is_time_to_move):
		_move(delta)
		if(time < TIME_TO_MOVE):
			time += delta 
		else:
			time = 0.0
			is_time_to_move = false
	else:
		#_shoot(delta)
		if(time < TIME_TO_SHOOT):
			time += delta 
		else:
			time = 0.0
			is_time_to_move = true

func get_shot():
	enemy_life = enemy_life -1

func _ready():
	trajectory.x = randf()
	trajectory.y = randf()
	enemy_pos = get_node(".").get_global_pos()
	add_to_group("enemies")
	set_fixed_process(true)