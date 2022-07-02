extends Node2D

var omen_count = 10
var interest = 0.4

var rooms = []
var rng

var altar = preload("res://scenes/Game/Omens/alter.tscn")
var blood_bed = preload("res://scenes/Game/Omens/blood_bed.tscn")
var chest = preload("res://scenes/Game/Omens/chest.tscn")
var gargoyle = preload("res://scenes/Game/Omens/gargoyle.tscn")
var locker = preload("res://scenes/Game/Omens/locker.tscn")
var portal = preload("res://scenes/Game/Omens/portal.tscn")
var recycler = preload("res://scenes/Game/Omens/recycler.tscn")
var safe = preload("res://scenes/Game/Omens/safe.tscn")

var omen_list = [altar,blood_bed,chest,gargoyle,locker,portal,recycler,safe]
var sec_omens = []
var big_omen = [altar]

var req_omens = {
	altar : 5
}

var max_omens = {
	blood_bed : 2,
	chest : 2,
	gargoyle : 2,
	locker : 2,
	portal : 2,
	recycler : 2,
	safe : 2
}

func _ready():
	rng = RandomNumberGenerator.new()
	for omen in omen_list:
		if not req_omens.keys().has(omen):
			sec_omens.append(omen)

func _start():
	for room in get_tree().get_nodes_in_group("room"):
		rooms.append(room)
	_req_spawn()
	_omen_spawn()

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
