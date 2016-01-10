
extends "res://scripts/character.gd"

#var resolution_constant = preload("res://scripts/resolution_constant.gd")

var player_speed = 200
#var basic_resolution_ratio = 0

var _first_screen_size

func _ready():
	#basic_resolution_ratio = float(resolution_constant.RESOLUTION_X) / float(resolution_constant.RESOLUTION_Y)
	#var device_resolution = get_viewport().get_rect().size
	#game_resolution_ratio = Vector2(resolution_constant.RESOLUTION_X/device_resolution.x, resolution_constant.RESOLUTION_Y/device_resolution.y)
	_first_screen_size = get_node("/root/game_variable").get_first_screen_size()
	self.get_node("camera").make_current()
	set_fixed_process(true)
	

func _follow_mouse(delta_t):
	#var device_resolution = get_viewport().get_rect().size
	#var resolution_ratio  = device_resolution.x / device_resolution.y
	#game_resolution_ratio = Vector2(resolution_constant.RESOLUTION_X/device_resolution.x, resolution_constant.RESOLUTION_Y/device_resolution.y)
	#var mouse_pos       = get_viewport().get_mouse_pos()
	var mouse_pos       = get_viewport().get_mouse_pos()
	var screen_size     = get_viewport().get_rect().size
	#mouse_pos = get_viewport_transform().affine_inverse().xform(self.get_viewport().get_mouse_pos())
	var player_position = (_first_screen_size.x / screen_size.x ) * get_viewport_transform().xform(self.get_pos())
	
	var delta_x         = player_position.x - mouse_pos.x
	var delta_y         = player_position.y - mouse_pos.y
	
	#print(mouse_pos)
	#print(player_position)

	var angle           = atan2(delta_x, delta_y)
	
	"""print(device_resolution.x, " / ", device_resolution.y)
	print(resolution_constant.RESOLUTION_X, " / ", resolution_constant.RESOLUTION_Y)
	print(resolution_ratio)
	print(basic_resolution_ratio)
	if(resolution_ratio - basic_resolution_ratio < -0.006 ):
		print("We are here")
		#mouse_pos.y     = mouse_pos.y - (resolution_constant.RESOLUTION_Y - (resolution_constant.RESOLUTION_X - 1/basic_resolution_ratio * resolution_constant.RESOLUTION_X/device_resolution.x)/2)
	else:
		if(resolution_ratio - basic_resolution_ratio > 0.006):
			print("We are there")
			#mouse_pos.y     = mouse_pos.y - (resolution_constant.RESOLUTION_X - (resolution_constant.RESOLUTION_Y - basic_resolution_ratio * resolution_constant.RESOLUTION_Y/device_resolution.y)/2)
	#mouse_pos           = mouse_pos * game_resolution_ratio"""
	
	self.set_rot(angle)
	
	pass

func _movement(delta):
	var player_position = self.get_pos()
	var is_moving       = false
	
	var rotation        = Matrix32()
	
	#press Z
	if(Input.is_action_pressed("player_move_up") and not Input.is_action_pressed("player_move_down")):
		player_position.y -= player_speed*delta
		is_moving = true
	else: 
		#press S
		if(Input.is_action_pressed("player_move_down") and not Input.is_action_pressed("player_move_up")):
			player_position.y += player_speed*delta
			is_moving = true
	
	# press D
	if(Input.is_action_pressed("player_move_right") and not Input.is_action_pressed("player_move_left")):
		player_position.x += player_speed*delta
		is_moving = true
	else: 
		# press L
		if(Input.is_action_pressed("player_move_left") and not Input.is_action_pressed("player_move_right")):
			player_position.x -= player_speed*delta
			is_moving = true
	
	if(is_moving == true):
		get_node("anim_move").play("move")
	else:
		get_node("anim_move").play("idle")
	
	get_node(".").move_to(player_position)
	_follow_mouse(delta)


func _fixed_process(delta):
	
	_movement(delta)
	
	#Player can activate a trigger with E:
	if(Input.is_action_pressed("player_action")):
		get_node("/root/game/dungeon").activate_trigger()

	
	

