extends Node2D

var init
var dist
var drag = -1
var icon = null
var slot = null

var active_pwr = null
var active_slot = null

func _slot_select(b):
	slot = b
	if b != null:
		icon = b.get_node("btn/icon")

func _active_pwr(slo):
	for sl in get_children():
		sl.get_node("btn/back").modulate = Color(1,1,1)
	if slo != null:
		active_slot = slo
		active_pwr = slo.item
		get_parent().get_node("use_btn")._repos(slo)
	else:
		active_slot = null
		active_pwr = null
		get_parent().get_node("use_btn")._shutoff()

func _input(event):
#PRESSED
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		if slot != null:
			if slot.item != null:
				if init == null:
					init = event.position
				dist = (event.position - init).length()
				if dist > 5:
					drag = event.get_index()
				if event.get_index() == drag:
					icon.global_position = event.position
#RELEASED
	if event is InputEventScreenTouch and !event.is_pressed():
		if drag == -1:
			_reset()
		if event.get_index() == drag: #IF SAME DRAG
			for s in get_tree().get_nodes_in_group("slot"):
				var pos = s.get_global_transform_with_canvas()[2] #CALCULATES WHERE IT IS ON SCREEN
				if (abs(event.position.x - pos.x) < s.bounds) and (abs(event.position.y - pos.y) < s.bounds):
					_check_slot(s)
					break
			icon.position = Vector2(0,0)
			drag = -1 #RESET DRAG
			_reset()

func _reset():
	slot = null
	init = null
	icon = null

func _check_slot(s):
	if slot != s:
		if s.power == null:
			s._add(slot.power)
			slot._empty()
		else:#SWAP
			var i = slot.power
			var j = s.power
			slot._add(j)
			s._add(i)
