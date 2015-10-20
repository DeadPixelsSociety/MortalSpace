
extends Sprite
var player_class = preload("res://scripts/player.gd") 
var ammo_scene   = preload("res://scenes/ammo.scn")

var game

var speed_rate = 0.05
var time_past  = 0.05

var counter = 0

func fire(delta):
	if(time_past >= speed_rate):
		get_node("anim_shoot").play("shoot_anim")
		var ammo_node = ammo_scene.instance()
		ammo_node.set_position_before_start(get_node(".").get_global_pos(), get_node("..").get_rot())
		get_node("/root/game").add_child(ammo_node)
		print("Bullet shooted")
		time_past = 0
	else:
		time_past += delta

func _process(delta):
	if(Input.is_mouse_button_pressed(BUTTON_LEFT) and get_node("..") extends player_class ):
		fire(delta)
		counter += 1
		print("click received and counter = ", counter)


func _ready():
	set_process(true)


