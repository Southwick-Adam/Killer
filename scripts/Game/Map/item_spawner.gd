extends Node2D

var item_count = 10

var rooms = []
var rng

var blood_pack = preload("res://scenes/Players/Items/blood_pack.tscn")
var key = preload("res://scenes/Players/Items/key.tscn")
var mana_stone = preload("res://scenes/Players/Items/mana_stone.tscn")
var med_kit = preload("res://scenes/Players/Items/med_kit.tscn")

var item_list = [blood_pack, key, mana_stone, med_kit]
var reg_items = []

var req_items = {
	
}

var item_values = {
	blood_pack : 0.6,
	key : 0.7,
	mana_stone : 0.9,
	med_kit : 0.6
}

func _ready():
	rng = RandomNumberGenerator.new()
	for item in item_list:
		if not req_items.keys().has(item):
			reg_items.append(item)

func _start():
	rooms = get_parent().rooms
	_req_spawn()

func _spawn(omen, room, center):
	var om = omen.instance()
	get_parent().add_child(om)
	if center:
		om.global_position = room.global_position
		_erase_room(room)
	else:
		rng.randomize()
		var r = rng.randi_range(0,room.get_node("points").get_children().size() - 1)
		var point = room.get_node("points").get_child(r)
		om.global_position = point.global_position
		point.queue_free()
		room.omen_count += 1
		if room.omen_count == 2:
			_erase_room(room)
	print(om.name)

func _erase_room(room):
	room.get_node("points").queue_free()
	rooms.erase(room)

func _req_spawn():
	for omen in req_omens.keys():
		var n = 0
		while n < req_omens[omen]:
			if big_omen.has(omen): #CENTER OMENS FIRST
				rng.randomize()
				var r = rng.randi_range(0,rooms.size() - 1)
				_spawn(omen, rooms[r], true)
			n += 1

func _omen_spawn():
	while omen_count > 0:
		for room in rooms:
			rng.randomize()
			if rng.randf() < interest:
				var om = _pick_omen()
				_spawn(om, room, false)
				omen_count -= 1
				max_omens[om] -= 1
				if max_omens[om] == 0:
					sec_omens.erase(om)
				if omen_count <= 0:
					return

func _pick_omen():
	rng.randomize()
	var r = rng.randi_range(0,sec_omens.size() - 1)
	return sec_omens[r]
