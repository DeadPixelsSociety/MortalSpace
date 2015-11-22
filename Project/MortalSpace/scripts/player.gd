
extends KinematicBody2D

var player_speed = 200

func _ready():
	set_fixed_process(true)
	

func _follow_mouse(delta_t, player_position):
	var mouse_pos       = self.get_global_mouse_pos()
	var delta_x         = player_position.x - mouse_pos.x
	var delta_y         = player_position.y - mouse_pos.y
	var angle           = atan2(delta_x, delta_y)
	
	
	get_node(".").set_rot(angle)
	
	pass

func _fixed_process(delta):
	var player_position = get_node(".").get_global_pos()
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
	_follow_mouse(delta, player_position)

