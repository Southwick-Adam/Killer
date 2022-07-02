extends Node2D

var item = null
var time = true

var selectable = true

var bounds = 45
onready var inv = get_parent()

func _on_btn_pressed():
	inv._slot_select(self)
	time = true
	$Timer.start()
	if inv.active_slot == self:
		inv._active_item(null)
		selectable = false

func _on_Timer_timeout():
	time = false
	selectable = true

func _on_btn_released():
	if time and selectable:
		if item != null:
			inv._active_item(self)
			$btn/back.modulate = Color(0,0,1)
		else:
			inv._active_item(null)

func _update():
	if item == null:
		$btn/icon.texture = null
		$btn/uses.text = ""
		if inv.active_slot == self:
			inv._active_item(null)
		#$btn/grade.texture = null
	else:
		$btn/icon.texture = item.icon
		$btn/uses.text = str(item.uses)
		#$btn/grade.texture = item.grade

func _add(i):
	item = i
	item.slot = self
	_update()

func _empty():
	item = null
	inv.full = false
	_update()
