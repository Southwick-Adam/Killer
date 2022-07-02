extends Node2D

var code = null
var test_code = []

func _set_code():
	code = test_code.duplicate()
	test_code.clear()
	$Label.text = "CODE SET"
	$Timer.start()
	get_parent().get_parent()._open()

func _check():
	if test_code == code:
		_open()
		test_code.clear()
	else:
		test_code.clear()
		$Label.text = "INCORRECT"

func _update():
	$Label.text = str(test_code)

func _open():
	$Label.text = "OPEN"
	get_parent().get_parent()._open()
	$Timer.start()

func _on_b1_pressed():
	_press(1)
func _on_b2_pressed():
	_press(2)
func _on_b3_pressed():
	_press(3)
func _on_b4_pressed():
	_press(4)
func _on_b5_pressed():
	_press(5)
func _on_b6_pressed():
	_press(6)
func _on_b7_pressed():
	_press(7)
func _on_b8_pressed():
	_press(8)
func _on_b9_pressed():
	_press(9)
func _on_b0_pressed():
	_press(0)
func _press(num):
	test_code.append(num)
	_update()

func _on_bx_pressed():
	test_code.clear()
	_update()
func _on_by_pressed():
	if code == null:
		_set_code()
	else:
		_check()

func _on_Timer_timeout():
	visible = false
