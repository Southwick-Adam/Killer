extends Node2D

onready var inventory = get_node("/root/Main/Player/HUD/Player_UI/inventory")

var entered = false
var locked = true

func _ready():
	$ext_slot.get_node("btn/back").self_modulate = Color(1, 1, 1, 0.45)
	#ASSIGN CONTENTS

func _unlock():
	if inventory.active_item != null:
		if inventory.active_item.is_in_group("key"):
			inventory.active_item._use()
			locked = false
			_open()

func _open():
	$ext_slot._active(true)

func _entered(b):
	$StaticBody2D/Sprite/light.visible = b
	entered = b
	if not b:
		$ext_slot._active(false)

func _on_TouchScreenButton_pressed():
	if entered:
		if locked:
			_unlock()
		else:
			$ext_slot._active(true)
