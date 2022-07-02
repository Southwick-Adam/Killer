extends Node2D

var entered = false

onready var inventory = get_node("/root/Main/Player/HUD/Player_UI/inventory")
onready var item = get_parent()

func _ready():
	$Area2D/Sprite.texture = get_parent().obj_sprite

func _entered(b):
	$Area2D/Sprite/back.visible = b
	entered = b

func _pick_up():
	if not inventory.full:
		inventory._pickup(item)
		queue_free()

func _on_TouchScreenButton_pressed():
	if entered:
		_pick_up()
