extends Node2D

var node_sprite = load("res://assets/Game/Map/MiniMap/miniRoom.png")
var branch_sprite = load("res://assets/Game/Map/MiniMap/miniConnect.png")

onready var Map = get_node("/root/Main/Map")
onready var center = get_viewport().get_visible_rect().size / 2

var room_size = 56
var buffer = 16
var repos = room_size + buffer
var rooms = {}

var x_coord = []
var y_coord = []

func _ready():
	$back.position = center
	_build()

func _build():
	for room in Map.get_child(0).get_children():
		_add_room(room)
	var x_center = (x_coord.max() + x_coord.min()) / 2
	var y_center = (y_coord.max() + y_coord.min()) / 2
	for child in get_children():
		if child != get_child(0) and child != get_child(1):
			child.position.x -= x_center - center.x
			child.position.y -= y_center - center.y
	$back.scale.x = ((x_coord.max() - x_coord.min()) / 64) + 2
	$back.scale.y = ((y_coord.max() - y_coord.min()) / 64) + 2

func _add_room(room):
	var room_coordinates = room.position / 704
	if rooms.keys().has(room):
		return
	_add_tile(room_coordinates, room)
	var c_rooms = room.connected_rooms
	if(c_rooms.get(Vector2(1, 0)) != null):
		_spawn_corridor(0, room_coordinates)
	if(c_rooms.get(Vector2(0, 1)) != null):
		_spawn_corridor(1, room_coordinates)

func _add_tile(coord, room):
	var temp = Sprite.new()
	temp.texture = node_sprite
	add_child(temp)
	temp.z_index = 1
	temp.self_modulate = Color(0.172549, 0.807843, 0.85098, 0.6)
	temp.scale = Vector2(0.875,0.875)
	temp.position = coord * repos + center
	temp.visible = false
	x_coord.append(temp.position.x)
	y_coord.append(temp.position.y)
	rooms[room] = temp

func _spawn_corridor(dir, i):
	var temp = Sprite.new()
	temp.texture = branch_sprite
	$corridors.add_child(temp)
	temp.visible = false
	temp.z_index = 0
	temp.self_modulate = Color(0.466667, 0.756863, 0.776471, 0.6)
	if dir == 0:
		temp.position = i * repos + Vector2((room_size + buffer)/2, 0) + center
	else:
		temp.rotation_degrees = 90
		temp.position = i * repos + Vector2(0, (room_size + buffer)/2) + center

func _update_player(room):
	var tile = rooms[room]
	$player.position = tile.position
	if not tile.visible:
		tile.visible = true
		for cor in $corridors.get_children():
			if abs(cor.global_position.x - tile.global_position.x) < 60 and abs(cor.global_position.y - tile.global_position.y) < 60:
				cor.visible = true
