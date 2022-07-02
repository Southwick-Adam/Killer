extends Node2D

var entered = false
var full = false

var rec = 0

func _ready():
	$ext_slot.get_node("btn/back").self_modulate = Color(1, 0, 0, 0.45)
	_add_contents()
	set_process(false)

func _process(_delta):
	if $ext_slot.item != null and not full:
		full = true
		$Timer.start()

func _add_contents():
	pass

func _recycle():
	pass

func _entered(b):
	$StaticBody2D/Sprite/light.visible = b
	entered = b
	if not b:
		$ext_slot._active(false)
		set_process(false)

func _on_TouchScreenButton_pressed():
	if entered:
		$ext_slot._active(true)
		set_process(true)

func _on_Timer_timeout():
	$ext_slot.item.queue_free()
	$ext_slot._empty()
	rec = -rec + 1
	if rec == 0:
		_recycle()
	full = false
