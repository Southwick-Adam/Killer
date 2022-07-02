extends Node2D

var entered = false

func _ready():
	for slot in $contents.get_children():
		slot.get_node("btn/back").self_modulate = Color(0.21, 0.21, 0.21, 0.45)

func _open():
	for slot in $contents.get_children():
			slot._active(true)

func _entered(b):
	$StaticBody2D/Sprite/light.visible = b
	entered = b
	if not b:
		for slot in $contents.get_children():
			slot._active(false)
		$CanvasLayer/keypad.visible = false

func _on_TouchScreenButton_pressed():
	if entered:
		$CanvasLayer/keypad.visible = true
