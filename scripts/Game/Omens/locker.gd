extends Node2D

var entered = false

func _ready():
	for slot in $contents.get_children():
		slot.get_node("btn/back").self_modulate = Color(0.72, 0.72, 0.72, 0.45)

func _entered(b):
	$StaticBody2D/Sprite/light.visible = b
	entered = b
	if not b:
		for slot in $contents.get_children():
			slot._active(false)

func _on_TouchScreenButton_pressed():
	if entered:
		for slot in $contents.get_children():
			slot._active(true)
