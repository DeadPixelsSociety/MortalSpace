
extends Node

const TILE_SIZE = 64
var   _SQRT_2_PI = sqrt(2 * PI)

var _expectation = 0.3
var _standard_deviation = 0.01

var _variance = _standard_deviation * _standard_deviation

# member variables here, example:
# var a=2
# var b="textvar"

func _normal_dsitribution():
	var x = randf()
	var delta_expectation = x - _expectation
	return 1/(_standard_deviation * _SQRT_2_PI) * exp( -(delta_expectation*delta_expectation)/(2*_variance) )

# algorithm find at:
#https://en.wikipedia.org/wiki/Normal_distribution
func _cumulative_distributive_function():
	var x = _normal_dsitribution()
	return x
	var sum = x
	var value = x
	
	for i in range(100):
		value = (value * x * x / (2 * i + 1))
		sum   = sum + value

	return (sum/_SQRT_2_PI) * exp(-(x*x)/2)

# algorithm find at : 
#http://www.gamasutra.com/blogs/AAdonaac/20150903/252889/Procedural_Dungeon_Generation_Algorithm.php
func _roundm(n, m):
		return floor((n + m -1)/m) * m

# algorithm find at : 
#http://www.gamasutra.com/blogs/AAdonaac/20150903/252889/Procedural_Dungeon_Generation_Algorithm.php
func get_random_point_in_circle(radius):
	var t = 2 * PI * randf()
	var u = randf() + randf()
	var r = null
	
	if(u > 1):
		r = 2-u
	else:
		r = u
	
	return Vector2( _roundm(radius * r * cos(t), TILE_SIZE), _roundm(radius * r * sin(t), TILE_SIZE) )

func _ready():
	# Initialization here
	pass


