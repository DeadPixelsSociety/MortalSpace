
extends KinematicBody2D

# member variables here, example:
# var a=2
# var b="textvar"

# bullet speed in pixel.s-1
var bullet_speed = 400

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
		get_node(".").queue_free()
	

func _ready():
	set_fixed_process(true)
	get_node(".").set_pos(bullet_position)
	get_node(".").set_rot(bullet_angle)
	
	#Ici on trace la trajectoire de la balle. 
	#Ne pas oublier que notre personnage commence à un angle 0 alors qu'il regarde vers le nord (l'axe Y).
	#Donc pour un angle 0 la balle doit partir plein nord, il faut donc utiliser le cosinus pour determiner la trajectoire en Y
	#et le sinus pour la trajectoire en X.
	bullet_trajectory.x = -sin(bullet_angle)
	bullet_trajectory.y = -cos(bullet_angle)


