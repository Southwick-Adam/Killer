extends Node2D

onready var player = get_node("/root/Main/Player")
var pressed = false
var entered = false

var taker = []
var giver = []

func _ready():
	set_process(false)

func _process(delta):
	if not giver.empty():
		$gline.visible = true
		$gline.remove_point(1)
		$gline.add_point(giver.back().global_position - global_position)
	else:
		$gline.visible = false
	if not taker.empty():
		$tline.visible = true
		$tline.remove_point(1)
		$tline.add_point(taker.back().global_position - global_position)
	else:
		$tline.visible = false
	if pressed and not taker.empty() and not giver.empty():
		giver.back().get_parent().health -= 5 * delta
		taker.back().get_parent().health += 5 * delta

func _entered(b):
	entered = b
	$StaticBody2D/Sprite/light.visible = b
	if b == false:
		pressed = false

func _on_TouchScreenButton_pressed():
	if entered:
		pressed = true

func _on_TouchScreenButton_released():
	pressed = false

func _on_giver_body_entered(body):
	set_process(true)
	if body.is_in_group("player_body"):
		giver.append(body)

func _on_giver_body_exited(body):
	if giver.has(body):
		giver.erase(body)
		_shut_down()

func _on_taker_body_entered(body):
	set_process(true)
	if body.is_in_group("player_body"):
		taker.append(body)

func _on_taker_body_exited(body):
	if taker.has(body):
		taker.erase(body)
		_shut_down()

func _shut_down():
	if giver.empty() and taker.empty():
		$gline.visible = false
		$tline.visible = false
		set_process(false)
