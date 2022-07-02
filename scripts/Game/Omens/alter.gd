extends Node2D

var entered = false

func _entered(b):
	entered = b
	$StaticBody2D/Sprite/light.visible = b

func _on_TouchScreenButton_pressed():
	if entered:
		pass
