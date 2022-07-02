extends Node2D

var power = null
var time = true

var selectable = true

var bounds = 45
onready var pwr = get_parent()

func _on_btn_pressed():
	pwr._slot_select(self)
	time = true
	$Timer.start()
	if pwr.active_slot == self:
		pwr._active_item(null)
		selectable = false

func _on_Timer_timeout():
	time = false
	selectable = true

func _on_btn_released():
	if time and selectable:
		if power != null:
			power._active_item(self)
			$btn/back.modulate = Color(0,0,1)
		else:
			pwr._active_item(null)

func _update():
	if power == null:
		$btn/icon.texture = null
		if pwr.active_slot == self:
			pwr._active_item(null)
	else:
		$btn/icon.texture = power.icon

func _add(i):
	power = i
	power.slot = self
	_update()

func _empty():
	power = null
	_update()
