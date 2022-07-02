extends Node2D

onready var player = get_node("/root/Main/Player")
var pressed = false

var blood = 0
var max_blood
var opened = false
var entered = false

func _ready():
	var rng = RandomNumberGenerator.new()
	max_blood = rng.randi_range(20,100)
	set_process(false)

func _process(delta):
	if pressed and not opened:
		if player.health > 5:
			player.health -= 5 * delta
			blood += 5 * delta
			if blood >= max_blood:
				_open()

func _open():
	_entered(false)
	opened = true

func _entered(b):
	if not opened:
		set_process(b)
		entered = b
		$StaticBody2D/Sprite/light.visible = b
		if b == false:
			pressed = false

func _on_TouchScreenButton_pressed():
	if entered:
		pressed = true

func _on_TouchScreenButton_released():
	pressed = false
	blood = ceil(blood)
	player.health = floor(player.health)
