
extends KinematicBody2D

# member variables here, example:
# var a=2
# var b="textvar"

var enemy_class = preload("res://scripts/enemy.gd") 
var player_class = preload("res://scripts/player.gd") 

# bullet speed in pixel.s-1
var bullet_speed = 800

var bullet_position   = Vector2(0.0, 0.0)
var bullet_angle      = 0.0

#trajectoire de la balle, par defaut la balle part plein nord.
var bullet_trajectory = Vector2(0.0, 1)

func set_position_before_start(bullet_pos, bullet_angl):
	bullet_position = bullet_pos
	bullet_angle    = bullet_angl

func _fixed_process(delta):
	#Ici on trace la trajectoire de la balle
	#bullet_position += bullet_trajectory*bullet_speed*delta
	#get_node(".").set_pos(bullet_position)
	#get_node(".").move(Vector2(0.0,0.0))

	bullet_position += bullet_trajectory*bullet_speed*delta
	get_node(".").set_pos(bullet_position)
	get_node(".").move(Vector2(0.0,0.0))
	if(is_colliding() ):
		if(get_collider() extends enemy_class):
			var myob = get_collider()
			myob.get_shot()
		if(get_collider() extends player_class):
			var myob = get_collider()
			myob.get_shot()
		get_node(".").queue_free()
	

func _ready():
	set_fixed_process(true)
	get_node(".").set_pos(bullet_position)
	get_node(".").set_rot(bullet_angle)
	
	bullet_trajectory.x = -sin(bullet_angle)
	bullet_trajectory.y = -cos(bullet_angle)


