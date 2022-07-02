extends Node2D

var omen_count = 0

var connected_rooms = {
	Vector2(1, 0): null,
	Vector2(-1, 0): null,
	Vector2(0, 1): null,
	Vector2(0, -1): null
}

var number_of_connections = 0
var occupants = []

func _open():
	var door1 = [Vector2(5,-1), Vector2(5,0)]
	var door2 = [Vector2(-6,0), Vector2(-6,-1)]
	var door3 = [Vector2(-1,5), Vector2(0,5)]
	var door4 = [Vector2(-1,-6), Vector2(0,-6)]
	var doors = [door1, door2, door3, door4]
	var i = 0
	while i < 4:
		if connected_rooms[connected_rooms.keys()[i]] != null:
			var n = 0
			while n < 2:
				$walls.set_cell(doors[i][n].x,doors[i][n].y, -1)
				n += 1
		i += 1

func _on_Area2D_area_entered(area):
	if area.is_in_group("body_area"):
		var player = area.get_parent().get_parent()
		occupants.append(player)
		player._change_rooms(self)

func _on_Area2D_area_exited(area):
	var player = area.get_parent().get_parent()
	if occupants.has(player):
		occupants.erase(player)

func _end():
	$points.queue_free()
