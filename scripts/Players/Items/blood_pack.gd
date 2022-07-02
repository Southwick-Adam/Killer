extends Node2D

var ongoing = true

var Item = preload("res://scenes/Players/Items/item.tscn")
var icon = preload("res://assets/tile.png")
var obj_sprite = preload("res://assets/tile.png")
var slot = null
var uses
var grade
var target

var cooldown = 0
var entered = false

var active

onready var inventory = get_node("/root/Main/Player/HUD/Player_UI/inventory")

func _ready():
	set_process(false)
	randomize()
	var rng = randf()
	if rng < 0.1:
		grade = 2
	elif rng < .3:
		grade = 1
	else:
		grade = 0
	_assign_values()

func _assign_values():
	var uses_array = [30, 50, 70]
	uses = uses_array[grade]

func _process(delta):
	if uses <= 0:
		slot._empty()
		queue_free()
	if target != null and target.health < 100:
		target.health += 7 * delta
		uses -= 7 * delta
	else:
		target.health = 100
	slot._update()

func _use(player):
	target = player
	set_process(true)

func _stop(player):
	target.health = ceil(target.health)
	uses = floor(uses)
	set_process(false)
	
