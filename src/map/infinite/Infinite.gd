extends Node2D

export (PackedScene) var Jump_Location
export (PackedScene) var Enemy
export (PackedScene) var Spitter
export (PackedScene) var Laser
export (PackedScene) var Platform

const WIDTH_MIN = 16
const WIDTH_MAX = 128
const position_size = 16
const width_random = 6
const height_random = 5

onready var map = $Map
onready var create_position = Vector2(0, 15)


func _ready():
	_infinite()

func _infinite():
	randomize()
	var rng = RandomNumberGenerator.new()
	var gap
	for i in range(10):
		create_position.x =  ( rng.randi() % width_random ) + 1
		gap = ( rng.randi() % height_random ) + 5 
		create_position.y -= gap
		_create_blocks(create_position)
		yield(get_tree().create_timer(0.1), "timeout")
		
		if gap > 8 and i > 1:
			var laser = Laser.instance()
			laser.position.x = 4 * position_size
			laser.position.y = ( create_position.y + 4 ) * position_size
			laser.rotation_degrees = 90
			add_child(laser)
			
		elif gap > 7 and i > 1:
			var platform = Platform.instance()
			platform.position.x = WIDTH_MIN
			platform.position.y = ( create_position.y + 3) * position_size
			add_child(platform)
			
		elif gap > 6 and i > 1:
			var enemy = Enemy.instance()
			enemy.position.x = WIDTH_MIN
			enemy.position.y = ( create_position.y + 3) * position_size
			add_child(enemy)
			
		elif gap > 5 and i > 1:
			var spitter = Spitter.instance()
			spitter.position.y = ( create_position.y + 4 ) * position_size
			if rng.randi() % 2:
				spitter.rotation_degrees = 180
				spitter.position.x = WIDTH_MAX
			else:
				spitter.position.x = WIDTH_MIN
			add_child(spitter)


func _create_blocks(create_position):
	var tile_id = map.tile_set.find_tile_by_name("tilev1.png") + 1
	var jump_location = Jump_Location.instance()
	jump_location.position.x = (create_position.x + 1) * position_size
	jump_location.position.y = (create_position.y + 1) * position_size
	add_child( jump_location)
	map.set_cellv(create_position, tile_id)
	map.set_cell(create_position.x + 1, create_position.y , tile_id)
	map.set_cell(create_position.x, create_position.y + 1, tile_id)
	map.set_cell(create_position.x + 1, create_position.y + 1, tile_id)
	map.update_bitmask_region()

func _random( size):
	var rng = RandomNumberGenerator.new()
	return ( ( rng.randi() % size ) + 1 )
