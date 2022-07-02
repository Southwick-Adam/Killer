extends Node

var room = preload("res://scenes/Game/Map/Room.tscn")

var number_rooms = 20
var gen_chance = 0.2
var room_size = 11 #in tiles

func _ready():
	randomize()
	_generate(rand_range(-1000, 1000))

func _generate(room_seed):
	seed(room_seed)
	var dungeon = {}
	var size = number_rooms
	_clear_old_map()
	var first_room = room.instance()
	$rooms.add_child(first_room)
	dungeon[Vector2(0,0)] = first_room
	first_room.position = Vector2(0,0)
	size -= 1

	while(size > 0):
		for i in dungeon.keys():
			if(randf() < gen_chance):
				var dir = [Vector2(1,0), Vector2(0,1), Vector2(-1,0), Vector2(0,-1)]
				var direction = dir[floor(rand_range(0,3.999))]
				var new_room_position = i + direction
				if(!dungeon.has(new_room_position)):
					var new_room = room.instance()
					$rooms.add_child(new_room)
					dungeon[new_room_position] = new_room
					new_room.position = new_room_position * room_size * 64
					size -= 1
				if(dungeon.get(i).connected_rooms.get(direction) == null):
					_connect_rooms(dungeon.get(i), dungeon.get(new_room_position), direction)

	while(!_is_interesting(dungeon)):
		for i in dungeon.keys():
			dungeon.get(i).queue_free()
		var sed = room_seed * rand_range(-1,1) + rand_range(-500,500)
		dungeon = _generate(sed)
	for r in $rooms.get_children():
		r._open()
	_done()

func _connect_rooms(room1, room2, direction):
	room1.connected_rooms[direction] = room2
	room2.connected_rooms[-direction] = room1
	room1.number_of_connections += 1
	room2.number_of_connections += 1

func _is_interesting(dungeon):
	var room_with_three = 0
	for i in dungeon.keys():
		if(dungeon.get(i).number_of_connections >= 3):
			room_with_three += 1
	return room_with_three >= 2

func _clear_old_map():
	for child in $rooms.get_children():
		child.queue_free()

func _done():
	$omen_spawner._start()
