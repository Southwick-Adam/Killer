extends Node2D

onready var inv = get_parent().get_node("inventory")
var item = null

func _repos(slo):
	global_position = slo.global_position - Vector2(100,0)
	if slo.item.is_in_group("use_btn"):
		item = slo.item
		visible = true
	else:
		_shutoff()

func _shutoff():
	item = null
	visible = false

func _on_btn_pressed():
	item._use()
